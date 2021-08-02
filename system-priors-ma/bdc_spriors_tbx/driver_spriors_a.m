%% -----------------------------------------------------------------
%  DRIVER_SPRIORS_A.M
%
%  System priors, Version A -- IRIS built-in options
%
%
%% -----------------------------------------------------------------
%
% System priors ARE built into IRIS. The specification is not
% fully general but can be used for many interesting priors, based on
% 	- impulse-response functions
% 	- spectral density
%   - function of coefficients
%
%
% For MORE general and flexible use of system priors work with
% |driver_spriors_b.m| where spriors are implented via external handle
% functions on top of IRIS (the original implementation for Andrle-Benes
% (2013) paper)
%
% mandrle@imf.org
%
% This is a simple ILLUSTRATION only... 
%% -----------------------------------------------------------------
clear; close all; clc;

% read the model
[m P ss] = readmodel(true);

% call the marginal priors (mpriors)
E = set_mpriors(P);

% ------------------------------------------------------
% Instantiate and parameterize the system prior object
% ------------------------------------------------------
% Other examples are in IRIS manual or in
% Andrle-Benes (2013) IMF WP: "SYSTEM PRIORS -- FORMULATING PRIORS ABOUT DSGE MODELS' PROPERTIES "
%
%


% NOTE: there seem to be a BUG, so having more than ONE SPRIOR does not work..
SP = systempriors(m);

	% implement sacrifice ratio prior for the model
	%SP = prior(SP, '', logdist.normal(-0.8,0.10)); % for this, needs to set globally TARGET as unit root

	% peak response to foreign shock prior
	SP = prior(SP, 'max(srf[L_GDP_GAP,SHK_L_GDP_RW_GAP,1:40])', logdist.normal(0.5,0.05));

	% peak response of core inflation to shock to an output gap
	% Use 'user-defined' function called "maxfun" to illustrate the
	% undocumented option of using 
	SP = prior(SP, 'maxfun(srf[L_GDP_GAP, SHK_L_GDP_GAP, 1:40])', logdist.normal(0.15,0.28));

	% limit on inflation dynamics. most of action should be in the first THREE years 
	%SP = prior(SP, 'maxfun(sum(abs(srf[DLA_CPIXFE,SHK_L_GDP_GAP,1:12])) / sum(abs(srf[DLA_CPIXFE,SHK_L_GDP_GAP,1:40]))',[],'lowerBound',0.9 );



% ------------------------------------------------------
% ESTIMATE -- with data or CALIBRATE without any DATA
% ------------------------------------------------------
rng = 1:100;

% create a database
dss = sstatedb(m, rng); 

% calibrate -- ignore the (uninformative) data
[PEst,Pos,Cov,Hess,M,V,Delta,PDelta] = estimate(m, dss, rng, E, SP, ...
	                 'evalLik', false,      ...   
	                 'evalPPriors', true,   ...   
	                 'evalSPriors', true,   ...   
					 'noSolution','penalty' ...
					 ); 

% sample from the compopund prior (sprior + mprior)
% keeping it simple with default options...

nDraw = 500;

fprintf('Sampling...\n');
[Theta,LogPost,ArVec,PosUpd,SgmVec,FinalCov] = arwm(Pos, nDraw, 'progress',true);


% Use IRIS to plot the marginal priors vs compound priors
[PrG,PoG,H] = grfun.plotpp(E,PEst,Theta);



