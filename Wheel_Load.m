function loads=Wheel_Load(Ay)
global mass_susp

global mass_dist


global cg_ht
global front_rch
global rear_rch
global rch
global front_rollstiff
global front_track
global rear_track
 
   DFz_geo_front=mass_susp*mass_dist*abs(Ay)*front_rch/(front_track*1000);
   DFz_geo_rear=mass_susp*(1-mass_dist)*abs(Ay)*rear_rch/(rear_track*1000);
   DFz_elast_front=mass_susp*abs(Ay)*(cg_ht-rch)*front_rollstiff/(front_track*1000);
   DFz_elast_rear=mass_susp*abs(Ay)*(cg_ht-rch)*(1-front_rollstiff)/(rear_track*1000);
   delta_f=DFz_geo_front+DFz_elast_front;
   delta_r=DFz_geo_rear+DFz_elast_rear;
  if (Ay>0)
      LF=0.5*mass_susp*9.8*mass_dist-delta_f;
      LR=0.5*mass_susp*9.8*(1-mass_dist)-delta_r;
      RF=0.5*mass_susp*9.8*mass_dist+delta_f;
      RR=0.5*mass_susp*9.8*(1-mass_dist)+delta_r;
      loads=[-LF,-LR,-RF,-RR];
  elseif(Ay<=0)
      LF=0.5*mass_susp*9.8*mass_dist+delta_f;
      LR=0.5*mass_susp*9.8*(1-mass_dist)+delta_r;
      RF=0.5*mass_susp*9.8*mass_dist-delta_f;
      RR=0.5*mass_susp*9.8*(1-mass_dist)-delta_r;
      loads=[-LF,-LR,-RF,-RR];
  end
 


  


  