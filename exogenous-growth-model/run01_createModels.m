%% Create different variants of an exogenous growth model 
%
% In this m-file, we create different versions of the same exogenous-growth
% model: a stationarized version (where all unit-root variables are
% transformed by dividing them by the level of productivity), and two
% unit-root (non-stationary) versions solved around different points on the
% balanced-growth path. Later on, we show that the properties of all these
% are identical. The bottom line is that we do not need to stationarized, 
% or transform balanced-growth path models in any other way, to be able to
% solve them and work with them.

%% Clear workspace

close all
clear


%% Create a baseline parameter database
%
% Choose some parameters. The parameter correspond to a model at yearly
% frequency.
%

p = struct( );
p.g = 1.03;
p.gamma = 0.60;
p.delta = 0.10;
p.beta = 0.97;


%% Load model files
%
% Load both versions of the model: one version is stationarized
% (`exogenousGrowthStationarized.model`), the other is the same model without
% any transformation (`exogenousGrowth.model`), i.e. variables are in
% their original forms, not stationarized, and the model code thus
% preserves the unit root in it.

m1 = Model.fromFile("model-source/exogenous-growth-stationarized.model", "assign", p);
m2 = Model.fromFile("model-source/exogenous-growth.model", "assign", p, "growth", true);

disp(m1)
disp(m2)


%%%
%
% Create another copy of the unit-root (non-stationary) model object for
% future use.

m3 = m2;


%% Calculate steady states (Balanced-growth paths)
%
% First, find the stationary steady state of `m1`. Then, find two different
% points on the balanced-growth path for the unit-root version of the
% model. Each of these two BGP points corresponds to a different level of
% productivity. It does not matter at all what point on the BGP is used --
% eventually, they all give exactly the same first-order solutions and the
% same results.
%
% When calculating the steady state for models in which some variables grow
% at a nonzero rate, set `Growth=true`; otherwise, it is assumed that all
% variables are flat in steady state.
%

m1 = steady(m1);
checkSteady(m1);

m2.A = 1;
m2 = steady(m2, "fixLevel", "A");
checkSteady(m2)

m3.A = 2;
m3 = sstate(m3, "fixLevel", "A");
checkSteady(m3)


%% Look at steady state (Balanced-growth path)
%
% The steady state, or balanced-growth path, is described by two numbers
% for each variable: the level of the variable, and its growth rate. In BGP
% models with unit roots, there is no unique levels toward which the
% variables would converge. What is needed to compute a valid first-order
% solution, though, is one single arbitrary point on the balanced-growth
% path. Think of it as a snapshot of the BGP at a particular (arbitrary)
% time.
%
% In IrisT, the two pieces of information that describe the steady state or
% BGP (level and growth) are stored as complex numbers. This is simply a
% convenient way of storing two pieces of information in one number; it has
% nothing to do with complex numbers themselves:
%
% * the real part is the level of the respective variables, 
% * the imaginary part describes the growth rate. For linearized variables, it is
% the difference between two consecutive periods, i.e. $\bar x_t - \bar
% x_{t-1}$, whereas for log-linearized variables, it is the gross rate of
% change, i.e. $\bar x_t / \bar x_{t-1}$.
%

access(m1, "steady")
access(m2, "steady")
access(m3, "steady")


%
% Get only the steady-state (balanced-growth path) levels.
%

access(m1, "steady-level")
access(m2, "steady-level")
access(m3, "steady-level")


%
% Get only the steady-state (balanced-growth path) growth rates.
%

access(m1, "steady-change")
access(m2, "steady-change")
access(m3, "steady-change")


%% Compute first-order solution
%
% The model `m1` is stationary, so IrisT simply computes the first-order
% Taylor expansion around the steady state, and solves for rational
% expectations. What about models `m2` and `m3`? It"s surprisingly easy.
% Compute the first-order expansion around any point on the model"s
% balanced-growth path. For instance, the Euler equation (with the
% expectations operator dropped for ease of notation)
%
% $$ \frac{1}{C_t} = \frac{ \beta (1+r_t) }{ C_{t+1}} $$
%
% is expanded around a point $C_t = \bar C$, $C_{t+1} = \bar C \cdot
% \widehat C$, and $r_t = \bar r$, where $\bar C$ and $\bar r$ denote the
% respective BGP levels, and $\widehat C$ denotes the gross rate of growth.
% (these quantities are reported above). Then, solve the system for
% rational expectations.
%
% It is easy to show that the above procedure is equivalent to the
% following steps:
%
% # Stationarize the model (i.e. transform the model into `m1`).
% # Solve the model for the transformed (stationarized) quantities, e.g.
% $y_t := Y_t/A_t$.
% # After solving the model, substitute back the original quantities, and
% hence obtain the law of motions for $Y_t$, etc.
%
% Instead of going through these often painful steps (it is rather
% laborious rewriting a larger model into its stationarized equivalent),
% the original unit-root model can be handled much more easily.
%

m1 = solve(m1) 
m2 = solve(m2)
m3 = solve(m3)


%% Save everything to mat file for further use

save mat/createModels.mat m1 m2 m3


