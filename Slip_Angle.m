function alpha=Slip_Angle(delta,yaw_r,Vx,Vy,Ay,algn_trq)
%if using (delta-SA term)then SA will be +ve, else SA -ve
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
global toe_in
global ATSC

%toe_angle=roll_steer(Ay);
toe_angle=[0 0];%roll_steer(Ay);

%aligning torque steer compliance
%steer_FL=(ATSC*algn_trq(1)/100)*pi/180;
%steer_FR=(ATSC*algn_trq(2)/100)*pi/180;

alpha_FL=((Vy+yaw_r*Lf)/(Vx-yaw_r*front_track/2))-delta+toe_angle(1)+toe_in*pi/180;%+steer_FL;
alpha_FR=((Vy+yaw_r*Lf)/(Vx+yaw_r*front_track/2))-delta+toe_angle(2)+toe_in*pi/180;%+steer_FR;
alpha_RL=1*((Vy-yaw_r*Lr)/(Vx-yaw_r*rear_track/2));
alpha_RR=1*((Vy-yaw_r*Lr)/(Vx+yaw_r*rear_track/2));
alpha=[alpha_FL,alpha_RL,alpha_FR,alpha_RR];
% for i=1:4
%     if alpha(i)>0.314
%         alpha(i)=0.314;
%     end
%     if alpha(i)<-0.314
%         alpha(i)=-0.314;
%     end
% end
