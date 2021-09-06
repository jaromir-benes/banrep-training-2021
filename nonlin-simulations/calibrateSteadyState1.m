

close all
clear

load mat/createModel.mat m


m1 = m;
m1.y = 1.5;
% m1.cpi = 0.9;
m1 = steady(m1, "fixLevel", ["y"], "blocks", false);




% m2 = m;
% m2.q = 3/400;
% m2.q_at_zz = 5/400;
% m2 = steady(m2, "exogenize", ["q", "q_at_zz"], "endogenize", ["c1_q", "c2_q"]);


