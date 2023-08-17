global FZ0 R0;
FZ0 = mean(t.FZ); % = FNOMIN = 'nominal wheel load'
R0  = .240;

INPUT = [t.SA,t.FZ,t.IA]; % slip, vert, incl

% el fudgo factoros:
LFZO = 0.100000E+01 ;%typarr( 31)
LCX = 0.100000E+01 ;%typarr( 32)
LMUX = 0.100000E+01 ;%typarr( 33)
LEX = 0.100000E+01 ;%typarr( 34)
LKX = 0.100000E+01 ;%typarr( 35)
LHX = 0.100000E+01 ;%typarr( 36)
LVX = 0.100000E+01 ;%typarr( 37)
LCY = 0.100000E+01 ;%typarr( 38)
LMUY = 0.100000E+01 ;%typarr( 39)
LEY = 0.100000E+01 ;%typarr( 40)
LKY = 0.100000E+01 ;%typarr( 41)
LHY = 0.100000E+01 ;%typarr( 42)
LVY = 0.100000E+01 ;%typarr( 43)
LGAY = 0.100000E+01 ;%typarr( 44)
LTR = 0.100000E+01 ;%typarr( 45)
LRES = 0.100000E+01 ;%typarr( 46)
LGAZ = 0.100000E+01 ;%typarr( 47)
LXAL = 0.100000E+01 ;%typarr( 48)
LYKA = 0.100000E+01 ;%typarr( 49)
LVYKA = 0.100000E+01 ;%typarr( 50)
LS = 0.100000E+01 ;%typarr( 51)
LSGKP = 0.100000E+01 ;%typarr( 52)
LSGAL = 0.100000E+01 ;%typarr( 53)
LGYR = 0.100000E+01 ;%typarr( 54)

%[LATERAL_COEFFICIENTS]
 PCY1                    =  1.70000000E+00;      %Shape factor Cfy for lateral forces
 PDY1                    = -2.82296020E+00;      %Lateral friction Muy
 PDY2                    =  1.91162390E-01;      %Variation of friction Muy with load
 PDY3                    =  1.12864140E+01;      %Variation of friction Muy with squared camber
 PEY1                    =  1.45305200E+00;      %Lateral curvature Efy at Fznom
 PEY2                    = -7.28245160E-03;      %Variation of curvature Efy with load
 PEY3                    =  1.29982370E-02;      %Zero order camber dependency of curvature Efy
 PEY4                    =  1.78004690E-01;      %Variation of curvature Efy with camber
 PKY1                    = -1.26655290E+02;      %Maximum value of stiffness Kfy/Fznom
 PKY2                    =  4.54537570E+00;      %Load at which Kfy reaches maximum value
 PKY3                    =  1.34572030E+00;      %Variation of Kfy/Fznom with camber
 PHY1                    =  1.98626370E-03;      %Horizontal shift Shy at Fznom
 PHY2                    =  3.30833890E-03;      %Variation of shift Shy with load
 PHY3                    =  1.30012390E-01;      %Variation of shift Shy with camber
 PVY1                    =  5.43414820E-02;      %Vertical shift in Svy/Fz at Fznom
 PVY2                    =  3.01602750E-02;      %Variation of shift Svy/Fz with load
 PVY3                    =  1.53185420E+00;      %Variation of shift Svy/Fz with camber
 PVY4                    = -7.94527020E-01;      %Variation of shift Svy/Fz with camber and load

clear AA RESNORM
A_str ={'PCY1' 'PDY1' 'PDY2' 'PDY3' 'PEY1' 'PEY2' 'PEY3' 'PEY4' 'PKY1' 'PKY2' 'PKY3' 'PHY1' 'PHY2' 'PHY3' 'PVY1' 'PVY2' 'PVY3' 'PVY4'};
A_old =[PCY1 PDY1 PDY2 PDY3 PEY1 PEY2 PEY3 PEY4 PKY1 PKY2 PKY3 PHY1 PHY2 PHY3 PVY1 PVY2 PVY3 PVY4];

options =optimset('MaxFunEvals',20000,'MaxIter',20000,'Display','final','TolX',1e-7,'TolFun',1e-7);

fig1=figure ('MenuBar','none','Name',['MF 5.27 Fy Fitting Results'],'Position',[5 50 1200 1400],'NumberTitle','off');

for k=1:60
[A,RESNORM(k),RESIDUAL,EXITFLAG] = lsqcurvefit('MF52_Fy_fcn',A_old',INPUT,t.FY,[],[],options);
AA(:,k)=A;
for n=1:18
subplot(3,6,n)
bar([AA(n,:)],'group')
title(['A(' num2str(n) ')' ' =' A_str{n}],'FontSize',8)
end


for n=1:18 % update A coefficients to newest values
%disp([A_str(n) '= A_old(' num2str(n) ') = ' num2str(A_old(n)) '; ' 'A(' num2str(n) ') = ' num2str(A(n)) ';']);
eval(['A_old(' num2str(n) ') = ' num2str(A(n)) ' -1*eps*rand;']); % bootstrap
end

drawnow
end


inx0 = find(t.IA == 0); % given camber points
sa0 = t.SA(inx0);
fz0 = t.FZ(inx0);
fy0 = t.FY(inx0);
mz0 = t.MZ(inx0);
mx0 = t.MX(inx0);

sa0 = reshape(sa0,nslips,nloads);
fz0 = reshape(fz0,nslips,nloads);
fy0 = reshape(fy0,nslips,nloads);
mz0 = reshape(mz0,nslips,nloads);
mx0 = reshape(mx0,nslips,nloads);

loads = fz0(3,:);


pacefy = MF52_Fy_fcn(A,INPUT);
pacefy0 = pacefy(inx0);

figure('Name','MF5.2 Fy Fitting Comparison','NumberTitle','off');
hold on
fnplt(csaps({slips,loads},fy0))
plot3(INPUT(inx0,1),INPUT(inx0,2),t.FY(inx0),'k.')
plot3(INPUT(inx0,1),INPUT(inx0,2),pacefy(inx0),'ro')
xlabel('Slip Angle')
ylabel('Vertical Load (N)')
zlabel('Lateral Force @ Camber=0')
legend('WAC Spline (IA=0.)','Data Pts (IA=0.)','MF5.2 (IA=0.)'),legend boxoff
title([testid ': ' tireid ' Pressure: ' num2str(pressure) ' Speed: ' num2str(speed)])

colormap(white)