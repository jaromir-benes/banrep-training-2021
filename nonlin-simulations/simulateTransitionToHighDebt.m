%% Simulate transition between two steady states


close all
clear

load mat/createModel.mat m


%% Create economy with high government debt

m1 = m;
m1.ss_nga_to_4ny = -0.90;

m1.c1_vg_to_ny = 0.2;
m1.c1_yg = 0.2;
m1.c0_yg = 0.7;
m1.c0_vg_to_ny = 0.98;

m1 = steady(m1);
checkSteady(m1);
m1 = solve(m1);


%% Simulate transition from low debt to high debt

d = steadydb(m, 0:40);

s = simulate( ...
    m1, d, 1:40, ...
    "method", "stacked", ...
    "prependInput", true ...
);

s.sacrifice_ratio = Series(-1, 0);
s = postprocess(m1, s, 0:40);

smc = databank.minusControl(m, s, d);

ch = databank.Chartpack();
ch.CaptionFromComment = true;
ch.Range = 0:40;

ch < ["pct_r", "pct_roc_cpi", "pct_y_gap", "pct_nga_to_4ny", "e"];
draw(ch, s);


