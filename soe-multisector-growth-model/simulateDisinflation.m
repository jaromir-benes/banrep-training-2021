
close all
clear

load mat/createModel.mat m

m1 = m;
m1.ss_roc_pc = 1.03^(1/4);

m1 = steady( ...
    m1 ...
    , "fixLevel", ["pc", "gdp", "gdp_dev", "cum_log_gdp_dev", "y0", "ax", "tot", "pm_fcy"] ...
    , "blocks", false ...
);

checkSteady(m1);
m1 = solve(m1);

d = steadydb(m, 1:40);
s = simulate( ...
    m1, d, 1:40 ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

smc = databank.minusControl(m, s, d);

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Transform = @(x) 100*(x-1);
ch.Round = 8;

ch < ["gdp_dev", "^100*cum_log_gdp_dev"];

ch < ["c", "i", "x", "m", "n", "nv", "k"];
ch < ["roc_pc^4", "r^4", "e", "w_to_pc", "u^4", "^100*nfa_to_ngdp"]

draw(ch, smc);

