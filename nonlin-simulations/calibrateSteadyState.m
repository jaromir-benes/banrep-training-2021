%% Techniques to use when calibrating steady state

close all
clear

load mat/createModel.mat m


%% Pick an arbitrary point on steady-state growth path

m1 = m;
m1.y = 2;
m1.cpi = m.cpi;
m1.py = m.py;

m1 = steady(m1, "fixLevel", ["y", "cpi", "py"], "blocks", false);
checkSteady(m1);

table([m, m1], ["steadyLevel", "steadyChange"])


%% Reverse engineer parameters

m2 = m;

m2.q = 4/400;
m2.q_at_100pct = 12/400;

m2 = steady( ...
    m2, ...
    "exogenize", ["q", "q_at_100pct"], ...
    "endogenize", ["c1_q", "c2_q"], ...
    "blocks", false ...
);

table([m, m2], ["steadyLevel", "steadyChange"])


z = -linspace(-1.5, 1.5, 100);
z = z';


q = glogc1(z, m.c1_q, m.c2_q, m.c3_q, m.c4_q, m.c5_q);
q2 = glogc1(z, m2.c1_q, m2.c2_q, m2.c3_q, m2.c4_q, m2.c5_q);

figure();
plot(-z, [q, q2]*400);
