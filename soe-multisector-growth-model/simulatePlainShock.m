
close all
clear

load mat/createModel.mat m

d = steadydb(m, 1:40);
% d.shk_c(1) = log(1.01);
% d.shk_uh(1) = log(1.01);
% d.shk_py(1) = log(1.01)/4;
% d.shk_i(1) = log(1.01);
% d.shk_k(1) = log(1.01);
% d.shk_x(1) = log(1.01);
d.shk_my(1) = log(1.01);

s = simulate( ...
    m, d, 1:40 ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

smc = databank.minusControl(m, s, d);

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Transform = @(x) 100*(x-1);
ch.Round = 8;

ch < ["gdp"];
ch < ["c", "i", "x", "my", "n", "nv", "k"];
ch < ["roc_pc^4", "r^4", "e", "w_to_pc", "u^4", "^100*nfa_to_ngdp", "pk"]

draw(ch, smc);

