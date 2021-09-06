%% Simulate crisis scenarios with fiscal reaction 


%% Clear workspace 

close all
clear
iris.required(20210802)

load mat/createModel.mat m

m.ss_nga_to_4ny = -0.80;
m = steady(m);
checkSteady(m);
m = solve(m);


%% Create initial steady state databank 

d0 = steadydb(m, 1:40);


% {

%% Plain vanilla private demand shock simulations


d10 = d0;
d10.shock_yh_gap(1:8) = -0.05;

% s10a = simulate( ...
%     m, d10, 1:40, ...
%     "prependInput", true ...
% );

% s10u = simulate( ...
%     m, d10, 1:40, ...
%     "prependInput", true, ...
%     "anticipate", false ...
% );

s11a = simulate( ...
    m, d10, 1:40, ...
    "method", "stacked", ...
    "prependInput", true ...    
);

% s11u = simulate( ...
%     m, d10, 1:40, ...
%     "method", "stacked", ...
%     "prependInput", true, ...
%     "anticipate", false ...
% );

% s = databank.merge("horzcat", s10a, s10u, s11a, s11u);
s = s11a;

smc = databank.minusControl(m, s, d0);
return

%}


%% 

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Highlight = 1:8;
ch.Round = 8;

ch < ["100*(yh_gap-1)", "100*(yg_gap-1)", "100*(roc_cpi^4-1)", "400*r", "e", "100*nga_to_4ny"];

draw(ch, s);

visual.hlegend( ...
    "bottom", ...
    "Linear Anticipated", ...
    "Linear Unnticipated", ...
    "Nonlinear Anticipated", ...
    "Nonlinear Unanticipated" ...
);


%% Scatter plot of q against z

figure();
hold on
scatter(100*[s10a.z, 4*s10a.q], "lineWidth", 10);
scatter(100*[s11a.z, 4*s11a.q], "lineWidth", 10);
xlabel("Minus the value of govt assets to GDP");
ylabel("Expected sovereign losses");

%}

%% Run scenario #1: Large demand shocks 

T = 8;

d1 = d0;

p1 = Plan.forModel(m, 1:40);
p1 = swap(p1, 1:T, ["yh_gap", "shock_yh_gap"]);

d1.yh_gap(1:T) = 0.85;

s1 = simulate( ...
    m, d1, 1:40 ...
    , "method", "stacked" ...
    , "prependInput", true ...
    , "plan", p1 ...
);


%% Run scenario #2: Fiscal expenditures to offset private shocks 

d2 = d0;
d2.shock_yh_gap = s1.shock_yh_gap;

p2 = Plan.forModel(m, 1:40);
p2 = swap(p2, 1:T, ["vg_to_ny", "shock_vg_to_ny"]);
p2 = swap(p2, 1:T, ["y_gap", "shock_yg"]);

d2.y_gap(1:T) = 1;
d2.vg_to_ny(1:T) = d2.vg_to_ny(0);

s2 = simulate( ...
    m, d2, 1:40 ...
    , "method", "stacked" ...
    , "prependInput", true ...
    , "plan", p2 ...
);



%% Run scenario #3: Fiscal expenditures and revenues to offset private shocks 

d3 = d0;
d3.shock_yh_gap = s2.shock_yh_gap;
d3.shock_yg = s2.shock_yg;

p3 = Plan.forModel(m, 1:40);
p3 = swap(p3, 1:T, ["vg_to_ny", "shock_vg_to_ny"]);

d3.vg_to_ny(1:T) = d3.vg_to_ny(1:T) - 0.05;

s3 = simulate( ...
    m, d3, 1:40 ...
    , "method", "stacked" ...
    , "prependInput", true ...
    , "plan", p3 ...
);


%% Report scenarios 

smc1 = databank.minusControl(m, s1, d0);
smc2 = databank.minusControl(m, s2, d0);
smc3 = databank.minusControl(m, s3, d0);

chartDb = databank.merge("horzcat", smc1, smc2, smc3);

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Round = 8;
ch.CaptionFromComment = true;
ch.Highlight = 0 : T;

ch < ["y_gap", "yg_gap", "yh_gap"];
ch < ["400*r", "roc_cpi", "cpi", "400*q", "100*z", "e"];
ch < ["nga_to_4ny", "vg_to_ny", "shock_yh_gap"];
draw(ch, chartDb);

visual.hlegend( ...
    "bottom" ...
    , "Scenario #1" ...
    , "Scenario #2" ...
    , "Scenario #3" ...
);

