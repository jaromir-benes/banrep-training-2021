function x = macro(x)

%
% __Directly calibrated steady state values__
%

x.ss_roc_y = (1 + 5/100)^(1/4);
x.ss_roc_cpi = (1 + 5/100)^(1/4);
x.ss_roc_re = (1 - 2/100)^(1/4);
x.ss_disc_fws_y = 0.05;
x.ss_prem = 1/400;


%
% __Dynamic parameters__
%

% Aggregate demand
x.c0_yh_gap = 0.85; % Autoregression
x.c1_yh_gap = 0.10; % Future income
x.c2_yh_gap = 0.03; % Real short-term rate
x.c4_yh_gap = 0.05; % Real exchange rate
x.c5_yh_gap = 0.10; % Foreign demand
x.c6_yh_gap = 0.50;
x.c7_yh_gap = 0.05;


% Potential output
x.c0_roc_y_tnd = 0.90; % Autoregression
x.c1_roc_y_tnd = 0; 0.005; % Hysteresis in GDP


% Forward output
x.c1_fws_y = 0.5; 


% Phillips curve
x.c0_roc_cpi = 0.65; % lag
x.c1_roc_cpi = 0.06; % output gap
x.c2_roc_cpi = 0.02; % Real exchange rate gap
x.c3_roc_cpi = 0.02; % Real exchange rate gap change
x.c4_roc_cpi = 0.5;


% Inflation expectations
x.c1_roc_cpi_exp = 0.85;


% Monetary policy reaction function
x.c0_r = 0.8;
x.c1_r = 2; 1.25;
x.c2_r = 0; 0.2;
x.c3_r = 0; 0.1;


% Real short-term cash rate trend, LCY
x.c0_rr_tnd = 0.95;


x.c1_e = 0.5;


% Weight on model-consistent exchange rate expectations
x.c1_e_exp = 0.75; % Weight on model-consistent expectations


% Interest premium gap
x.c0_prem_gap = 0.85; % Autoregression


% Exchange rate markets
x.c1_prem = 0.5; % Response in interest premium to lending conditions


% Real exchange rate trend
x.c0_roc_re_tnd = 0.95; % Autoregression
x.c1_roc_re_tnd = 0; 0.001; % Hysteresis in real exchange rate

end%

