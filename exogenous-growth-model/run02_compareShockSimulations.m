%% Compare shock simulations in stationarized and unit-root models
%
% In this m-file, we show that the three model versions (stationarized and
% unit-root) have identical shock responses.
%


%% Clear workspace 
%
% Clear all variables, close all figure windows, clear command window, and
% check the IrisT version.
%

close all
clear

load mat/createModels.mat m1 m2 m3


%% Simulate a productivity shock
%
% Simulate the same shock, `u`,  in the three versions of the model.
%

d1 = steadydb(m1, 1:40);
d1.u(1) = 0.10;
s1 = simulate(m1, d1, 1:40, "prependInput", true);

d2 = steadydb(m2, 1:40);
d2.u(1) = 0.10;
s2 = simulate(m2, d2, 1:40, "prependInput", true);

d3 = steadydb(m3, 1:40);
d3.u(1) = 0.10;
s3 = simulate(m3, d3, 1:40, "prependInput", true);


%% Plot the productivity shock responses
%
% Plot the responses in the same variables (or their transformations) for
% all three model versions.
%

ch = databank.Chartpack();
ch.Range = 0:40;
ch.AxesSettings = {"yLimitMethod", "tight"};

ch < ["y", "c", "i", "r", "k", "dA"];

draw(ch, s1);
title("Productivity shock: Model m1");


ch = databank.Chartpack();
ch.Range = 0:40;
ch.AxesSettings = {"yLimitMethod", "tight"};

ch < ["Y/A", "C/A", "I/A", "r", "K/A", "dA"];

draw(ch, s2);
title("Productivity shock: Model m2");

draw(ch, s3);
title("Productivity shock: Model m3");


%% Compare numerically the shock responses
% 
% Display the numerical values and their differences for stationarized
% output `y` from the three simulated models.
%

disp([ s1.y, s2.Y/s2.A, s2.y, s3.Y/s3.A, s3.y ])
disp([ s2.Y/s2.A-s1.y, s2.y-s1.y, s3.Y/s3.A-s1.y, s3.y-s1.y])
maxabs([ s2.Y/s2.A-s1.y, s2.y-s1.y, s3.Y/s3.A-s1.y, s3.y-s1.y])


%% Unit-root responses
%
% In models `m2` and `m3`, the responses inthe unit-root variables (note
% that the shock has permanent effect on all of them) can be obtained
% directly.
%

ch = databank.Chartpack();
ch.Range = 0:40;
ch.AxesSettings = {"yLimitMethod", "tight"};

ch < ["Y", "C", "I", "r", "K", "dA"];

draw(ch, databank.merge("horzcat", d2, s2));
visual.hlegend("bottom", "No Shock", "Shock Simulation");
title("Productivity shock in full levels: Model m2");

draw(ch, databank.merge("horzcat", d3, s3));
visual.hlegend("bottom", "No Shock", "Shock Simulation");
title("Productivity shock in full levels: Model m3");

