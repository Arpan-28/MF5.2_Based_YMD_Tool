function camber=roll_camber(Ay)

global mass_susp
global stat_camber
global cg_ht

global rch

global kphi

roll_angle=mass_susp*Ay*(cg_ht-rch)/(kphi*1000);

p1 = -0.015391;
p2 = 0.64137;
p3 = 5.2849e-05;
p4 = -0.0084494;
p5 = 0.55204;
p6 = 2.8497e-05;

camber_front=p1*(roll_angle^2) + p2*(roll_angle) + p3;
camber_rear=p4*(roll_angle^2) + p5*(roll_angle) + p6;

if roll_angle>=0
    RF=stat_camber+camber_front;
    RR=stat_camber+camber_rear;
    LF=-1*camber_front;
    LR=-1*camber_rear;
    camber=[LF LR RF RR];
else
    RF=stat_camber-1*camber_front;
    RR=stat_camber-1*camber_rear;
    LF=camber_front;
    LR=camber_rear;
    camber=[LF LR RF RR];
end
end

    