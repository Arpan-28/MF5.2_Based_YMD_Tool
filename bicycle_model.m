global mass_susp
global wheelbase
global mass_dist
global Lf
global Lr
global cg_ht
global front_rch
global rear_rch
global rch
global front_rollstiff
global front_track
global rear_track
global kphi
global toe_in
global algn_trq;
global ATSC;
global stat_camber;

mass_susp=250;
wheelbase=16;
mass_dist=0.5; 
Lf=wheelbase*(1-mass_dist);
Lr=wheelbase*mass_dist;
cg_ht=90;
front_rch=40;
rear_rch=70;
rch=65;
front_rollstiff=0.65;
front_track=1.2;
rear_track=1.17;
kphi=500000; %Nm/deg...roll rate
toe_in=2; %degrees
algn_trq=[0,0];
ATSC=-0.0; %deg/100 Nm
stat_camber=0;

delta=linspace(-22,22,100);
beta=linspace(-12,12,14);
Vx=110*5/18;
yaw_moment=0;
answer=zeros(10,15);
c=1;
counter=1;
t=0;
temp1=0;
R_pred=100;
R_calc=R_pred;
forces=[0 0 0 0];
moments=[0,0,0,0];
Net_force=(Vx^2)/R_pred;
FY=0;
MZ=0;

for i=1:14
    for j=1:100
        t=1;
        R_pred=100;
        while(t==1)
            alpha=Slip_Angle(delta(j)*pi/180,Net_force/Vx,Vx,Vx*tan(beta(i)*pi/180),...
                  Net_force,algn_trq);
            loads=Wheel_Load(Net_force);
            gam1=roll_camber(Net_force);
            
       
            for k=1:4
                FY=Tire_Model_test_1(loads(k),alpha(k),gam1(k),A);
                forces(k)=FY;
                %MZ=pac4lite_YMD(Q,loads(k),alpha(k)*180/pi);
                %moments(k)=MZ;
            end
            
            %algn_trq=[moments(1),moments(3)];
            
            if(counter==1)
                Net_force=(forces(1)*cos((delta(j)*pi/180)-alpha(1))+...
                           forces(3)*cos((delta(j)*pi/180)-alpha(3))+...
                           forces(2)*cos(alpha(2))+forces(4)*cos(alpha(4)))/mass_susp;
                R_calc=Vx^2/Net_force;
                temp1=R_calc;
                R_pred=R_calc;
                counter=2;
            else
                Net_force=(forces(1)*cos((delta(j)*pi/180)-alpha(1))+...
                           forces(3)*cos((delta(j)*pi/180)-alpha(3))+...
                           forces(2)*cos(alpha(2))+forces(4)*cos(alpha(4)))/mass_susp;
                R_calc=(Vx*Vx)/Net_force;
                if((R_calc-temp1)<=0.0000001*temp1)
                    yaw_moment=((forces(1)*cos((delta(j)*pi/180)-alpha(1))...
                                +forces(3)*cos((delta(j)*pi/180)-alpha(3)))*Lf)...
                                -((forces(2)*cos(alpha(2))+forces(4)*cos(alpha(4)))*Lr);
                    answer_beta(c,:)=[-1*Vx*Vx/R_calc,yaw_moment,beta(i),delta(j),...
                                 alpha(1)*180/pi,alpha(2)*180/pi,R_calc,loads(1)/9.8,...
                                 loads(2)/9.8,loads(3)/9.8,loads(4)/9.8,forces(1),...
                                 forces(2),forces(3),forces(4)];
                    c=c+1;
                    t=2;
                else
                    R_pred=0*temp1+1*R_calc;
                    temp1=R_calc;
                end
            end
            
        end
    end
end






delta=linspace(-22,22,14);
beta=linspace(-12,12,100);
Vx=110*5/18;
yaw_moment=0;
answer=zeros(10,15);
c=1;
counter=1;
t=0;
temp1=0;
R_pred=100;
R_calc=R_pred;
forces=[0 0 0 0];
moments=[0,0,0,0];
Net_force=(Vx^2)/R_pred;
FY=0;
MZ=0;

for i=1:100
    for j=1:14
        t=1;
        R_pred=100;
        while(t==1)
            alpha=Slip_Angle(delta(j)*pi/180,Net_force/Vx,Vx,Vx*tan(beta(i)*pi/180),...
                  Net_force,algn_trq);
            loads=Wheel_Load(Net_force);
            gam2=roll_camber(Net_force);
            
       
            for k=1:4                
                FY=Tire_Model_test_1(loads(k),alpha(k),gam2(k),A);
                forces(k)=FY;
                %MZ=pac4lite_YMD(Q,loads(k),alpha(k)*180/pi);
                %moments(k)=MZ;
            end
            
            %algn_trq=[moments(1),moments(3)];
            
            if(counter==1)
                Net_force=(forces(1)*cos((delta(j)*pi/180)-alpha(1))+...
                           forces(3)*cos((delta(j)*pi/180)-alpha(3))+...
                           forces(2)*cos(alpha(2))+forces(4)*cos(alpha(4)))/mass_susp;
                R_calc=Vx^2/Net_force;
                temp1=R_calc;
                R_pred=R_calc;
                counter=2;
            else
                Net_force=(forces(1)*cos((delta(j)*pi/180)-alpha(1))+...
                           forces(3)*cos((delta(j)*pi/180)-alpha(3))+...
                           forces(2)*cos(alpha(2))+forces(4)*cos(alpha(4)))/mass_susp;
                R_calc=(Vx*Vx)/Net_force;
                if((R_calc-temp1)<=0.0000001*temp1)
                    yaw_moment=((forces(1)*cos((delta(j)*pi/180)-alpha(1))...
                                +forces(3)*cos((delta(j)*pi/180)-alpha(3)))*Lf)...
                                -((forces(2)*cos(alpha(2))+forces(4)*cos(alpha(4)))*Lr);
                    answer_delta(c,:)=[1*Vx*Vx/R_calc,yaw_moment,beta(i),delta(j),...
                                 alpha(1)*180/pi,alpha(2)*180/pi,R_calc,loads(1)/9.8,...
                                 loads(2)/9.8,loads(3)/9.8,loads(4)/9.8,forces(1),...
                                 forces(2),forces(3),forces(4)];
                    c=c+1;
                    t=2;
                else
                    R_pred=0*temp1+1*R_calc;
                    temp1=R_calc;
                end
            end
            
        end
    end
end





