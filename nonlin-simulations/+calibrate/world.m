function x = world(x)

% Directly calibrated steady state values
x.ss_rrw = 0.65 /400;
x.ss_roc_cpiw = 1.02 ^(1/4);

% Autoregression parameters
x.c0_yw_gap = 0.8;
x.c0_roc_cpiw = 0.8;
x.c0_rw = 0.9;
x.c0_rrw_tnd = 0.9;

end%

