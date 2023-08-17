k=1;
c=[0 0 0];

while( k<40000)
  scatter(answer_beta(k:k+1999,1),answer_beta(k:k+1999,2),[],'b','filled');
  hold on;
  k=k+2000;
end

m=1;
d=[1 0 1];
answer_delta=sort(answer_delta,4);
while( m<40000)
  scatter(answer_delta(m:m+1999,1),answer_delta(m:m+1999,2),[],'r','filled');
  hold on;
  m=m+2000;
end
grid on;

legend('Beta-Isolines','Delta-Isolines');
xlabel('Lateral Acceleration(m/s2)');
ylabel('Yaw Moment(Nm)');

