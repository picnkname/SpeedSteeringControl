%%locomotionv4
%requirements
%0 steady state path error for any operable velocity of the robot (-.5/.5)
%m/s
%error may be generated with acceleration
%%so
%must track path error, its integral ,and derivitive
%%path error is signed distance of center of robot from closest path point

%%closest path point (CPP) is the closest point by perpindicular distance 
%%from the path to the center of the robot

%%must track theta error, the difference in the angle of the closest path
%%point and the robot (in world coordinates)
%%must also integrate and potentially derivate theta error (hopefully just
%%integrate)

%must estimate distance to goal for status purposes

%must accept unit step input with gain 1 (input should be speed setpoint)

%%linearstates
%left wheel speed = k1 * EPp + k2 * EPi + k3 * EPd + k4*ETp + k5*ETi + Ka*Ac - Ke*ELS
%right wheel speed = -(k1 * EPp + k2 * EPi + k3 * EPd + k4*ETp + k5*ETi) + Ka*Ac - Ke*ERS
%path error states 1-3 P I D
%EPp = EPkA * Ac + Decay, EPi = integral(EPp) and decay;
%EPd = 0 (get it from deriving linear state as sensor measurement and have
%it decay in this model)
%theta error states 1-2 P I
%ETp = ETkA * Ac + Decay, ETi = integral(ETp) and decay;
%general accel %grr, speed setpoint must operate accel
%Ac = AcKe*(speed error I) - (speed error D = Ac = Decay)
%let AcKe = .1
%left wheel speed error I
%right wheel speed error I


%%notes
%No input leads to diverging wheel steady state
%Input with LQR leads to steady state wheel vel below set point

wheeldecay = -.1;
k1 = .1; k2 = .02; k3 = -5; %EP  P I D
k4 = .1; k5 = .02;% ET P I
kA = .2; Ke = .4;
EPpDecay = -.1;
EPiDecay = -.1;
EPkA = 1; ETkA = 1;
ETpDecay = -.1;
ETiDecay = -.1;
AcDecay = -.4;
AcKe = -.1;
SpeedErrorDecay = -.5;
EPdDecay = -.2;

numstates = 10
A = [wheeldecay, 0, k1, k2, k3, k4, k5, kA,-Ke, 0;%leftwheel
     0,wheeldecay, -k1,-k2,-k3,-k4,-k5, kA, 0,-Ke;%rightwheel
     0,0,     EPpDecay,  0,  0,  0,  0,EPkA,0,  0;%EPp
     0,0,1,   EPiDecay,  0,  0,  0,  0,  0,  0;%EPi
     0,0,0,          0,  EPdDecay,  0,  0,  0,  0,   0;%EPd
     0,0,0,          0,  0, ETpDecay, 0,ETkA,0,  0;%ETp
     0,0,0,          0,  0,  1,  ETiDecay,  0,  0,  0;%ETi
     0,0,0,          0,  0,  0, 0,AcDecay,AcKe,  AcKe;%(Ac)celleration
     1,0,0,          0,  0,  0,      0, 0,  SpeedErrorDecay,  0;%left wheel speed error
     0,1,0,          0,  0,    0,    0, 0,  0,  SpeedErrorDecay];%right wheel speed error
     
Ref = zeros(10,1);
Ref (9) = .3; %m/s for the left wheel
Ref (10) = .3; %m/s for the right wheel

eig(A)

B = zeros(10,2);
B(1,1) = 1; B(2,1) = -1;
B(8,2) = 1;

Q = eye(10);
R = eye(2);
eig([Q,zeros(10,2);zeros(2,10),R]);
Kx = lqr(A,B,Q,R)
lqrPoles = eig(A - B*Kx)
X = zeros(10,1);
dt = .1;
time = 0:dt:60;

U = [0;0];

Xplot = zeros(length(X),length(time));
Uplot = zeros(length(U),length(time));

XplotIndex =1;
figure();
for t = time;
     dX = A*X - Ref +B*U;
     X = X + dX*dt;
     U =[0;0];
     %U = -Kx*X;
     
     Xplot(:,XplotIndex) = X;
     Uplot(:,XplotIndex) = U;
     if (t>15)
              subplot(2,2,1);
         plot([0:dt:t], Xplot(1:2,1:XplotIndex), [0:dt:t],Uplot(:,1:XplotIndex), '--');
         legend('Left Wheel Speed','Right Wheel Speed','Speed Input', 'Steering Input' );
              subplot(2,2,2);
         plot([0:dt:t], Xplot(3:5,1:XplotIndex));
         legend('EPp', 'EPi', 'EPd');
              subplot(2,2,3);
         plot([0:dt:t], Xplot(6:7,1:XplotIndex));
         legend('ETp', 'ETi');
              subplot(2,2,4);
         plot([0:dt:t], Xplot(8:10,1:XplotIndex));
         legend('Accel', 'Left Wheel Servo', 'Right Wheel Servo');
         pause(.01);
     end
     XplotIndex = XplotIndex +1;
end
     
