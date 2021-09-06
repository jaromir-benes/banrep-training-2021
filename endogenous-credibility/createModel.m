%% Read and Solve the Nonlinear Credibility Model
%
% In this m-file script, we read the endogenous credibility model file,
% `endogenous-credibility.model`, assign its parameters, find the steady
% state of the model, calculate the first-order solution matrices, and save
% everything for future use. 

%% Clear Workspace

close all
clear
%#ok<*NOPTS>
 
%% Load and Calibrate Endogenous Credibility Model
%
% Call the Model object constructor `Model( )` to read the model file
% `endogenous-credibility.model` and create a model object. Calibrate the model
% parameters. Note that the parameter `delta`, which determines the convexity
% of the Phillips curve, must be greater than zero.

m = Model.fromFile("model-source/endogenous-credibility.model");

m.ss_rr = 0;
m.ss_pie = 2;

m.alpha = 0.1;
m.sigma = 0.1;
m.beta = 0.99;
m.gamma = 0.05;
m.delta = 0.4;
m.kappa = 4;
m.rho_targ = 0;
m.omega = 1;

m.slope_r = 0.1;

m.rho_y_gap = 0.75;
m.rho_c = 0.97;
m.rho_r = 0.80;
m.rho_y_tnd = 0.90;

m.c = 1;

access(m, "parameter-values")

%% Find Steady State
%
% In nonlinear models, the steady-state needs to be found (numerically)
% first, before we calculate the first-order solution matrices. By default,
% the function `steady( )` assumes that the model does not have nonzero
% growth rates in any of its variables -- the `endogenous-credibility.model`
% complies with this assumption. It is a good idea to always verify that
% the calculated steady-state holds (the function `checkSteady( )`
% would throw an error message with the list of inaccurate equations).

m = steady(m);
checkSteady(m); 

table(m, ["SteadyLevel", "SteadyChange", "Form", "Description"])

%% Calculate First-Order Solution Matrices
%
% The first-order solution matrices are not only used in
% linearized simulations, but they are used in nonlinear (stacked-time)
% simulation algorithms in several places.k

m = solve(m);

c = Comodel.fromFile("model-source/endogenous-credibility.model", ":cond", "disc");
c = assign(c, access(m, "parameter-values"));
c.disc = 0.96;
c = steady(c);
checkSteady(c);
c = solve(c);


%% Save Everything for Further Use

save mat/createModel.mat m c

