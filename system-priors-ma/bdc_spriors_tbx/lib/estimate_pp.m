%% -----------------------------------------------------------------
%  SIMPLE WRAPPER FOR ESTIMATION OF MODELS PARSED WITH IRIS
%% -----------------------------------------------------------------
function [m out] = estimate_pp(m, range, E, db, props, options)
%% -----------------------------------------------------------------
%
% (c) Michal Andrle
% mandrle@imf.org, michal_andrle@yahoo.com
%
% estimate the model with priors, log-lik and property-restrictions
%% -----------------------------------------------------------------


% check if the model is solved or can be solved for initial conds
if issolved(m)
	P = get(m,'parameters');
else
	error('Please initialize the model with starting values of the parameters.\n');
end


% -------------------------------------------------------
% unpack the priors and initial values |P|
% -------------------------------------------------------
[x0 lb ub pr pNames] = prior2vect(E,m);

% -------------------------------------------------------
% pass the loss function to the solver
% -------------------------------------------------------

% A] Initialize the loss function with arguments
options.range = range;
fn = @(x)lossfun(x, m, E, db, props, options);

% B] run the nonlinear search algorithm
fprintf('estim_pp :: estimating the posterior mode of the model... \n');
	[xstar,objstar,EXITFLAG,OUTPUT,LAMBDA,grad,HESS_1] = ...
    	                fmincon(fn,x0, ...
        	            [],[],[],[],lb,ub,[],options.optimset);

% compute the full hessian anyway -- [takes time, but a useful check]
fprintf('Updating the Hessian at x0... \n');
gstep = [1e-2; 1];
H1 = hess1(fn, xstar,  gstep);

% -------------------------------------------------------
% create the parameter structure with estimates
% -------------------------------------------------------
P = x2param(xstar,pNames);
m = assign(m,P);
m = solve(m);

out.xstar 	= xstar;
out.P	 	= P;
out.HESS1 	= HESS_1;
out.H1      = H1;
out.m     	= m ;

end %of the main function
