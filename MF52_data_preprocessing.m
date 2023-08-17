f2=figure;
figure(f2);
subplot(6,1,1);
  plot(V)
  title('velocity');
subplot(6,1,2);
  plot(P);
  title('pressure');
subplot(6,1,3);
  plot(IA);
  title('camber');
subplot(6,1,4);
  plot(FZ);
  title('normal loads');
subplot(6,1,5);
  plot(SA);
  title('slips');
subplot(6,1,6);
  plot(RL);
  title('RL');

  
k = waitforbuttonpress;
p1 = get(gca,'CurrentPoint'); % button down detected
finalRect = rbbox; % return figure units
p2 = get(gca,'CurrentPoint'); % button up detected
dstart = min([round(p1(1)) round(p2(1))]); 

if dstart < 1
dstart = 1; 
end

dstop = max([round(p1(1)) round(p2(1))]); %greatest point L--> R or R--> L
if dstop > length(V)
dstop = length(V); 
end

channels_processed_IA=IA(dstart:dstop);
channels_processed_FZ=FZ(dstart:dstop);
channels_processed_SA=SA(dstart:dstop);
channels_processed_V=V(dstart:dstop);
channels_processed_P=P(dstart:dstop);
channels_processed_FY=FY(dstart:dstop);
channels_processed_MZ=MZ(dstart:dstop);
channels_processed_MX=MX(dstart:dstop);
channels_processed_RL=RL(dstart:dstop);
channels_processed_FX=FX(dstart:dstop);

subplot(6,1,1);
  plot(channels_processed_V)
  title('velocity');
subplot(6,1,2);
  plot(channels_processed_P);
  title('pressure');
subplot(6,1,3);
  plot(channels_processed_IA);
  title('camber');
subplot(6,1,4);
  plot(channels_processed_FZ);
  title('normal loads');
subplot(6,1,5);
  plot(channels_processed_SA);
  title('slips');
subplot(6,1,6);
  plot(channels_processed_RL);
  title('RL');
 
  
m = 1:length(channels_processed_SA); % point counter
sp = spline(m,smooth(channels_processed_SA)+.5); % fit a generic spline to locate zeros. Round 6
z = fnzeros(sp); % location of zero crossings
z = round(z(1,:)); % no dups and integer indices
no_of_zeros=length(z);

if length(z) == 60
type=1;
nsweeps = length(z)/4;
if nsweeps ~= 15;
errordlg({'15 Slip Sweeps Not Found','Reload and Try Again'},'ttc2 Processing Message');
return;
end
        for n=1:nsweeps
        sweeps(n,1)=z(4*n-2);
        sweeps(n,2)=z(4*n );
        end
elseif length(z) == 30
type=2;
nsweeps = length(z)/2;
if nsweeps ~= 15
errordlg({'15 Slip Sweeps Not Found','Reload and Try Again'},'ttc2 Processing Message')
return
end
        sweeps(1,1)=1;
        sweeps(1,2)=z(2);
        for n=2:nsweeps
        sweeps(n,1)=z(2*n-2);
        sweeps(n,2)=z(2*n);
        end
end

disp('Start MF5.2')
slips=[-10:10]';

nincls = 3;
if type==1
incls=[round(mean(channels_processed_IA(z(1):z(20)))) round(mean(channels_processed_IA(z(21):z(40))))...
       round(mean(channels_processed_IA(z(41):z(60))))];
elseif type==2
incls=[round(mean(channels_processed_IA(z(1):z(10)))) round(mean(channels_processed_IA(z(11):z(20))))...
       round(mean(channels_processed_IA(z(21):z(30))))];
end    
nloads = nsweeps/nincls;
nslips = length(slips);
pressure = round(mean(channels_processed_P)); 
speed = round(mean(channels_processed_V));

for k=1:nincls % k is the camber number
for m = 1:nslips; % m is the slip number
for n = 1:nloads % n is load number
sa = channels_processed_SA(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
ia = channels_processed_IA(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
fz = channels_processed_FZ(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
fy = channels_processed_FY(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
mz = channels_processed_MZ(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
mx = channels_processed_MX(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
rl = channels_processed_RL(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
fx = channels_processed_FX(sweeps((k-1)*nloads+n,1):sweeps((k-1)*nloads+n,2));
inx = find(abs(sa) > 11); % Removes the 'bad' flyback' in the TIRF data.
sa(inx) =[];
ia(inx) =[];
fz(inx) =[];
fy(inx) =[];
mz(inx) =[];
mx(inx) =[];
rl(inx) =[];
fx(inx) =[];

load(n) = mean(fz);
fypts(k,m,n) = csaps(sa,fy,.1,slips(m));
fzpts(k,m,n) = load(n);
sapts(k,m,n) = slips(m);
iapts(k,m,n) = incls(k);
mzpts(k,m,n) = csaps(sa,mz,.1,slips(m));
mxpts(k,m,n) = csaps(sa,mx,.1,slips(m));
end
end
end

t.SA = reshape(sapts,nslips*nloads*nincls,1);
t.IA = reshape(iapts,nslips*nloads*nincls,1);
t.FZ = reshape(fzpts,nslips*nloads*nincls,1);
t.FY = reshape(fypts,nslips*nloads*nincls,1);
t.MZ = reshape(mzpts,nslips*nloads*nincls,1);
t.MX = reshape(mxpts,nslips*nloads*nincls,1);



