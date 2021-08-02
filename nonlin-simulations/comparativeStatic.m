%% Simple comparative static 


%% Clear workspace 

close all
clear
iris.required(20210802)

load mat/createModel.mat m


%% Create multiple parameter variants 

m = alter(m, 20);
m.ss_nga_to_4ny = linspace(0, -1.5, 20);
m = steady(m);

figure();
plot(100*real(m.ss_nga_to_4ny), 400*real(m.r));
title("Interest rate as a function of government debt to GDP ratio");
xlabel("Government debt to GDP ratio, % annualized")
ylabel("Interest rate, % PA");


