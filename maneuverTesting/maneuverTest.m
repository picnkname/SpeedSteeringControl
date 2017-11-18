%maneuverTest
%this file serves as the calling script for testing the maneuver planners.
%firstly it shall provide an easy means of testing the oneTurnSolver and
%plotting results graphically using maneuverPlot


initialPose = [.5,0,0];
waypoint = [2,-1,-pi/3];
f = figure();
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);

oneTurnPlotter(initialPose(1), initialPose(2), initialPose(3),  waypoint(1),waypoint(2),waypoint(3));

bgcolor = f.Color;


%bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
%                'String','0','BackgroundColor',bgcolor);
%bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],...
%                'String','5','BackgroundColor',bgcolor);
xPos = uicontrol('Parent',f,'Style','slider','Position',[81,134,210,23],...
              'value',initialPose(1), 'min',0, 'max',7.5);
xPosTit = uicontrol('Parent',f,'Style','text','Position',[120,105,100,23],...
                'String','Xpos','BackgroundColor',bgcolor);
            
yPos = uicontrol('Parent',f,'Style','slider','Position',[81,94,210,23],...
              'value',initialPose(2), 'min',-2, 'max',2);
yPosTit = uicontrol('Parent',f,'Style','text','Position',[120,65,120,23],...
                'String','Ypos','BackgroundColor',bgcolor);
            
thPos = uicontrol('Parent',f,'Style','slider','Position',[81,54,210,23],...
              'value',initialPose(3), 'min',-pi, 'max',pi);
thPosTit = uicontrol('Parent',f,'Style','text','Position',[120,25,120,23],...
                'String','theta','BackgroundColor',bgcolor);
            
wayX = uicontrol('Parent',f,'Style','slider','Position',[291,134,210,23],...
              'value',waypoint(1), 'min',0, 'max',7.5);
wayXTit = uicontrol('Parent',f,'Style','text','Position',[320,105,100,23],...
                'String','wayX','BackgroundColor',bgcolor);
            
wayY = uicontrol('Parent',f,'Style','slider','Position',[291,94,210,23],...
              'value',waypoint(2), 'min',-2, 'max',2);
wayYTit = uicontrol('Parent',f,'Style','text','Position',[320,65,120,23],...
                'String','wayY','BackgroundColor',bgcolor);
            
wayTh = uicontrol('Parent',f,'Style','slider','Position',[291,54,210,23],...
              'value',waypoint(3), 'min',-pi, 'max',pi);
wayThTit = uicontrol('Parent',f,'Style','text','Position',[320,25,120,23],...
                'String','wayTh','BackgroundColor',bgcolor);
            
            
xPos.Callback  = @(es,ed) oneTurnPlotter(es.Value,   yPos.Value, thPos.Value,  waypoint(1),waypoint(2),waypoint(3));

yPos.Callback  = @(es,ed) oneTurnPlotter(xPos.Value, es.Value,   thPos.Value,  waypoint(1),waypoint(2),waypoint(3));

thPos.Callback = @(es,ed) oneTurnPlotter(xPos.Value, yPos.Value, es.Value,     waypoint(1),waypoint(2),waypoint(3));

wayX.Callback  = @(es,ed) oneTurnPlotter(xPos.Value, yPos.Value, thPos.Value,  es.Value,   waypoint(2),waypoint(3));

wayY.Callback  = @(es,ed) oneTurnPlotter(xPos.Value, yPos.Value, thPos.Value,  waypoint(1),es.Value,   waypoint(3));

wayTh.Callback = @(es,ed) oneTurnPlotter(xPos.Value, yPos.Value, thPos.Value,  waypoint(1),waypoint(2),es.Value);
