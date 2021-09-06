
close all
clear

if ~exist("mat", "dir")
    mkdir mat
end


m = Model.fromFile( ...
    "model-source/soe-growth.model" ...
    , "growth", true ...
    , "savePreparsed", "model-source/preparsed.model" ...
);

m.ss_roc_pm_fcy = 1.01^(1/4);
m.ss_tot = 1;
m.ss_rw_fcy = 1.02^(1/4);

m.ss_roc_ay = 1.03^(1/4);
m.ss_roc_ax = 1.015^(1/4);
m.ss_roc_pc = 1.04^(1/4);
m.ss_roc_tot = 1.01^(1/4);
m.ss_uh = 1.00^(1/4);
m.ss_of_to_ngdp = 0;

m.beta = 0.95^(1/4);

m.eta = 0;
m.delta = 0.075;
m.nu = 0.3;
m.gamma_m = 0.15;
m.gamma_k = 0.30;
m.mu = 1.4;
m.alpha_m = 0.40;

m.beta_y1 = 1;
m.beta_y2 = 1;
m.beta_y0 = 1;

m.xi_i = 1;
m.xi_x = 0.75;
m.xi_y2 = 0.5;
m.xi_y1 = 0.5;
m.xi_py = 150;

m.chi = 0.7;
m.sigma = 0;
m.rho_r = 0.75;
m.kappa_1 = 3.5;
m.omega = 0.6;

m.rho_ay = 0.9;
m.rho_ax = 0.9;
m.rho_tot = 0.9;
m.rho_uh = 0.75;

m.rho_w = 0.7;

m.phi_0 = NaN;
m.phi_1 = 0.03;

m.nfa_to_ngdp = -0.50 * 4;

m.pc = 1;
m.y0 = 1;
m.ax = 1;
m.tot = 1;
m.pm_fcy = 1;
m.gdp = 1;
m.gdp_dev = 1;
m.cum_log_gdp_dev = 1;

m = steady( ...
    m ...
    , "fixLevel", ["pc", "gdp", "gdp_dev", "cum_log_gdp_dev", "y0", "ax", "tot", "pm_fcy"] ...
    , "exogenize", ["nfa_to_ngdp"] ...
    , "endogenize", ["phi_0"] ...
    , "blocks", false ...
);

checkSteady(m);

t = table( ...
    m, ["steadyLevel", "steadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", "steadyTable.xlsx" ...
)

m = solve(m);

save mat/createModel.mat m

