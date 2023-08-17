function F_lat=Tire_Model_test_1(Fz,alpha,gamma,A)
PCY1 = A(1);
PDY1 = A(2);
PDY2 = A(3);
PDY3 = A(4);
PEY1 = A(5);
PEY2 = A(6);
PEY3 = A(7);
PEY4 = A(8);
PKY1 = A(9);
PKY2 = A(10);
PKY3 = A(11);
PHY1 = A(12);
PHY2 = A(13);
PHY3 = A(14);
PVY1 = A(15);
PVY2 = A(16);
PVY3 = A(17);
PVY4 = A(18);
  
  global FZ0;
  dfz=(Fz-FZ0)/FZ0;
  SHY=PHY1+PHY2*dfz+PHY3*gamma;
  SVY=(Fz*(PVY1+PVY2*dfz+(PVY3+PVY4*dfz)*gamma))*1;
  alpha_y=alpha+SHY;
  Cy=PCY1;
  muy=1*((PDY1+PDY2*dfz)*(1-PDY3*gamma^2));
  Dy=muy*Fz;
  Ey=(PEY1+PEY2*dfz)*(1-(PEY3+PEY4*gamma)*sign(alpha_y));
  Ky=(PKY1*FZ0*sin(2*atan(Fz/(PKY2*FZ0)))*(1-PKY3*abs(gamma)))*1;
  By=Ky/(Cy*Dy);
  F_lat=-0.74*round(Dy*sin(Cy*atan(By*alpha_y-Ey*(By*alpha_y-atan(By*alpha_y))))+SVY);
end