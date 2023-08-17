k=1;

while( k<40000)
  m1=max(answer_beta(k:k+1999,1));
  m2=min(answer_beta(k:k+1999,1));
  xx1=linspace(m2,m1,30);
  yy1=fit(answer_beta(k:k+1999,1),answer_beta(k:k+1999,2),'poly3');
  yy2=yy1(xx1);
  plot(xx1,yy2,'b--o');
  hold on;
  k=k+2000;
end
legend('Beta-Isolines');

m=1;
answer_delta=sort(answer_delta,4);
while( m<40000)
  m3=max(answer_delta(m:m+1999,1));
  m4=min(answer_delta(m:m+1999,1));
  xx2=linspace(m4,m3,30);
  yy3=fit(answer_delta(m:m+1999,1),answer_delta(m:m+1999,2),'poly3');
  yy4=yy3(xx2);
  plot(xx2,yy4,'r--o');
  hold on;
  m=m+2000;
end
grid on;
legend('Beta-Isolines','Delta-Isolines');
xlabel('Lateral Acceleration(m/s2)');
ylabel('Yaw Moment(Nm)');