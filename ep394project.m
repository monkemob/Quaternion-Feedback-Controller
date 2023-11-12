clc
clear
close all

%Yea just delete everything but use as a template for ode45

%simulation times
time=[0:1:150];
% k=.000361;
% c=.02666;
%need to be hardcoded
% q1c=+/-.851;
% q2c=0;
% q3c=0;

[T,X]=ode45(@diffeq3,time,[.37;-.11;.42;1.91;.1345;.3364;.2018]); 

figure()
plot(T,X(:,1))
hold on
plot(T,X(:,2))
hold on
plot(T,X(:,3))
hold off
xlabel('Time (s)')
ylabel('Angular velocity (rad/s)')
legend('wx','wy','wz')
title('Pointing to GEO Angular Velocities')

figure()
plot(T,X(:,4))
hold on
plot(T,X(:,5))
hold on
plot(T,X(:,6))
hold on
plot(T,X(:,7))
hold on
plot([0 150],[.851 .851],'--')
hold off
xlabel('Time (s)')
ylabel('Quaternions')
legend('q0','q1','q2','q3')
title('Pointing to GEO Quaternions')

yourMatrix=[T,X(:,4),X(:,5),X(:,6),X(:,7),zeros(151,1)+6600, zeros(151,1), zeros(151,1)]
writematrix(yourMatrix, "output.csv", "Delimiter", "comma")

%diff eqs 
function dydt3=diffeq3(t,y) 
dy1=.8404*y(2)*y(3)-28.22*(.00361*(.851-y(5))+.02666*y(1));
dy2=-.8404*y(1)*y(3)-28.22*(.00361*(0-y(6))+.02666*y(2));
dy3=-177.3*(.00361*(0-y(7))+.02666*y(3));
dy4=.5*(-y(5)*y(1)-y(6)*y(2)-y(7)*y(3));
dy5=.5*(y(4)*y(1)-y(7)*y(2)+y(6)*y(3));
dy6=.5*(y(7)*y(1)+y(4)*y(2)-y(5)*y(3));
dy7=.5*(-y(6)*y(1)+y(5)*y(2)+y(4)*y(3));
dydt3=[dy1;dy2;dy3;dy4;dy5;dy6;dy7];
end

