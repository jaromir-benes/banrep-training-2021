%% Simulate Nonlinearities During Disinflation
%
% Simulate the nonlinear credibility model to show different outcomes
% during disinflation, depending on the initial level of credibility.
% Evaluate the effect of nonlinearities compared to a linearized model.

%% Clear Workspace

close all
clear


%% Load Model Object

load mat/createModel.mat m


%% Simulate Permanent Unanticipated Disinflation
%
% Simulate an unanticipated disinflation shock (reducing the inflation
% target by 1 pp) in four different ways:
%
% # With the first-order approximate solution (linearized model), i.e. when
% neither nonlinear Phillips curve nor the credibility matter.
%
% # With taking into account both nonlinearities, starting with the
% central bank fully credible, $c_t = 1$.
%
% # With taking into account both nonlinearities, starting with low
% credibility, $c_t = 0.5$.
%
% # With taking into account both nonlinearities, starting with low
% credibility, $c_t = 0$.
%
% Change `phi=1` (#phi) to allow for permanent changes in the target
% through the shock `et`. Note that this parameter change does not affect
% the steady state (no need to call the function `sstate` again) but it
% does change the solution matrices, and hence the model has to be resolved
% (#resolve). Create a database with steady-state time series for each
% variable, and create a shock to the target (#steadydb).
%
% Simulate first the linearized model; in this case, the Phillips curve
% convexity and the credibility do not matter (#linear).
%
% Run a nonlinear simulation starting with full credibility (#fullCred).
% This is the default, steady-state value found in the input database `d`
% -- hence, the initial condition for `c` does not need to be changed
% (#noChange). To run a nonlinear simulation, set the option `'Method='`
% to `'Selective'` (#nonlinearOpt); this means a so-called
% equation-Selective nonlinear simulation method. By default, the
% nonlinearities will be preserved over the simulation horizon, i.e. 40
% periods; beyond that horizon, the linearized solution determines the
% terminal condition.
%
% Simulate again, starting with low credibility; adjust the initial
% condition for `c` accordingly (#lowCred). Simulate one last time, 
% starting with no credibility. Change the initial condition for `c` to
% zero (#noCred). In addition, because the nonlinearities kick in more
% severly, increase the maximum number of iterations (`'Maxiter=' 5, 000`
% instead of the default 100), and reduce the step size in each iteration
% (`'lambda=' 0.5` instead of the default `1`). Otherwise, the simulation
% would crash (try that by changing these options).
%
% Nonlinear simulations return three extra output arguments:
%
% * A flag (`true` or `false`), `flag2`, `flag3`, `flag1.5`, indicating
% convergence.
%
% * A time series of add-factors, `af2`, `af3`, `af1.5`, that need to be
% added to the first-order approximation of nonlinear equations (i.e. those
% marked with `=#` in the model file) to achieve an exact nonlinear
% simulation.
%
% * A time series of discrepancies between the LHS and RHS in nonlinear
% equations, `di2`, `di3`, `di1.5`.
%
% These extra output argument are analyzed below.

m.rho_targ = 1; 
checkSteady(m);
m = solve(m);

d = steadydb(m, 1:40);
d.shk_targ(1) = -1;


%% High credibility initially 

d1 = d;
d1.c(-2:0) = 1;

l1 = simulate( ...
    m, d1, 1:40 ...
    , "prependInput", true ...
);

[n1, info1] = simulate( ...
    m, d1, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

s1 = simulate( ...
    m, d1, 1:40 ...
    , "prependInput", true ...
    , "method", "selective" ...
);


%% Medium Credibility Initially

d2 = d;
d2.c(-2:0) = 0.5;

l2 = simulate( ...
    m, d2, 1:40 ...
    , "prependInput", true ...
);


[n2, info2] = simulate( ...
    m, d2, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


s2 = simulate( ...
    m, d2, 1:40 ...
    , "prependInput", true ...
    , "method", "selective" ...
);


%% Low Credibility Initially

d3 = d;
d3.c(-2:0) = 0.1;

l3 = simulate( ...
    m, d3, 1:40 ...
    , "prependInput", true ...
);

[n3, info3] = simulate( ...
    m, d3, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

s3 = simulate( ...
    m, d3, 1:40 ...
    , "prependInput", true ...
    , "method", "selective" ...
);


%% Plot results

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Round = 8;

ch < access(m, "transition-variables");
ch < "cumsum(y_gap)/4";

draw(ch, databank.merge("horzcat", n1, n2, n3));
visual.hlegend("bottom", "High 1", "Medium 0.5", "Low 0.1")

draw(ch, databank.merge("horzcat", n1, n3, l3));
visual.hlegend("bottom", "High 1 Nonlinear", "Low 0.1 Nonlinear", "Low 0.1 Linear");

draw(ch, databank.merge("horzcat", n3, s3));
visual.hlegend("bottom", "Low 0.1 Stacked", "Low 0.1 Selective");


