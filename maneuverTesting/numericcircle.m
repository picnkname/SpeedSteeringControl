%try agian
initialpose = [0,0,0];
waypoint = [2.75,1.29,.15];


f = figure();
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);

radius = uicontrol('Parent',f,'Style','slider','Position',[81,134,420,23],...
              'value',initialPose(1), 'min',0, 'max',7.5);
          
radius.Callback = @(es,ed) plotNumericCircles(es.Value, waypoint(1),waypoint(2),waypoint(3));
    fieldlength = 7.38;

xlim([0,fieldlength]);
ylim([-fieldwidth/2,fieldwidth/2]);
pbaspect([fieldlength,fieldwidth,1]);