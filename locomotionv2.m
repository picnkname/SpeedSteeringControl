%locomotion area
%takes speed and steering input into simulation and shows model

%simulation variables
dt = .01;
time = 0:dt:10;

Ul =1;
Ur =1;

SpeedInput = 1;
SteeringInput = 3.5;

robotState = [1;1;0];

%plotting records
crumbcounter = 21;
crumbperiod =20;
crumbindex=0;
crumbs = zeros(2,int32(length(time)/crumbperiod));

Uplot = zeros(2,length(time));
Uplotindex=1;

sscPlot = zeros(12,length(time));
sscPlotindex=1;


for t = time;

  [Ul, Ur] = ssc(SpeedInput, SteeringInput, Ul, Ur);
  
  drobotState = robotdynamics(Ul, Ur, robotState(3), dt);
  robotState = robotState + drobotState;
    
    
    
    
  %plot robot
  subplot(3,1,1);
  hold on;
  robotdraw(robotState(1),robotState(2),robotState(3));
  %%plot path points
  %scatter(path(1,:),path(2,:),'green','*');
  %record crumbs
  crumbcounter = crumbcounter+1;
  if (crumbcounter>crumbperiod)
    crumbcounter=0;
    crumbindex = crumbindex+1;
    crumbs(:,crumbindex) = robotState(1:2);
  end
  scatter(crumbs(1,1:crumbindex),crumbs(2,1:crumbindex));

  %plot motor inputs
  subplot(3,1,2);
  Uplot(:,Uplotindex) = [Ul;Ur];
  plot([0:dt:t],Uplot(:,1:Uplotindex));
  Uplotindex = Uplotindex+1;
  
  %plot servo outputs
  %subplot(3,1,3);
  %sscPlot(:,sscPlotindex) = sscControlY;
  %plot([0:dt:test],sscPlot(:,1:sscPlotindex));
  %sscPlotindex = sscPlotindex +1;
  
end
subplot(3,1,1);
robotdraw(robotState(1),robotState(2),robotState(3)); %needed to hold last frame