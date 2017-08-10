%path solver, takes destination x,y,theta and returns number of different
%manuevers (1 or 2?) and their setpoints (distance and turn radius)

%if tan(theta)*(-x1)+y1 >0, then solution is one circular arc
% that is, if the waypoint line was extended back and intersects with the
% current position line after the waypoint.

%coordinate system: +X is fwd, +Y is Left

function [Dist, Radius] = waypoint2setpoints(x1, y1, theta)
%equations were done for +y = fwd and +x = right
%need to transform
%tempX = x1;
%tempY = y1;
%x1 = tempY;
%y1 = -tempX;

theta = -theta;

if (tan(theta)*(-x1) + y1 >=0)
   Radius = -.5 * (x1 + y1*y1/x1);
   Dist = -atan(1/tan(theta)) * Radius;
else
    Radius=0;
    Dist=10;
    
end


