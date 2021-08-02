%% -----------------------------------------------------------------
%  DRIVER_SPRIORS_B.M  -- TEACHING VERSION
%
%  System priors, Version B -- built on TOP of IRIS
%
%% -----------------------------------------------------------------
%
% This is the most general implementation of system priors for estimation
% and CALIBRATION, based on user-defined function handles.
%
% Unlike built-in (and optimized) implementation, this allows for more
% complex system priors (e.g. endogenize/exogenize, etc.) and interactions.
% The code does not make use of any lower-level IRIS options to speed up
% the computations, making it easier to read and adjust.
%
%
% Contact: mandrle@imf.org, Michal Andrle (IMF RES)
% https://michalandrle.weebly.com/system-priors.html [for code updates]
%
% All this should run on OCTAVE, though checkt the use of fmincon
%% -----------------------------------------------------------------

% housekeeping
clear; close all; clc;

% read the model
[m P ss] = readmodel(true);

% call and set the marginal priors (mpriors)
E = set_mpriors(P);

% ------------------------------------------------------
% Instantiate and parameterize the system prior object
% ------------------------------------------------------
% Other examples are in IRIS manual or in
% Andrle-Benes (2013) IMF WP: "SYSTEM PRIORS -- FORMULATING PRIORS ABOUT DSGE MODELS' PROPERTIES "
%
%
% ------------------------------------------------------

% estimation options
ESTOPTS = struct();

ESTOPTS.do_prior   = true;	% eval marginal priors
ESTOPTS.do_spriors = true;	% eval system priors [system/property priors]
ESTOPTS.do_lik     = false;	% eval/ignore log-likelihood using the KF

ESTOPTS.debug    = false;     % no debug messages
ESTOPTS.noSolve  = 'penalty'; % don't stop when models don't solve

% Set the optimizer params, knock yourself out...
ESTOPTS.optimset = optimset('Algorithm','active-set','Display','iter','tolx',1e-5,'tolfun',1e-5,'MaxFunEvals',5000);

% carry anything you want there [if needed for Spiors or such...]
ESTOPTS.user_defined_stuff = [];


% ------------------------------------------------------
% SYSTEM PRIORS --
% ------------------------------------------------------
do_sprior = true;

if do_sprior
    n_sp = 1; % number of system priors used for the exercise

	% pre-allocate 
    sprior_mu  = zeros(n_sp,1);
    sprior_cov = zeros(n_sp);
    
    % 1) prior on dynamics dying out after four years on ygap{-1}
	% ---------------------------------------------------
    sprior_mu(1,1)  = -0.80;  % why, just for fun...
    %sprior_mu(1,1)  = -2.00; % also try THIS to see what happens...
    sprior_cov(1,1) =  0.10;
 
	% 2) prior on ...
	% ---------------------------------------------------
    %sprior_mu(1,1)  = x.xx; % why, just for fun...
    %sprior_cov(1,1) = x.xx;
   

	% ---------------------------------------------------
	% Packaging spriors for the estimation
	% ---------------------------------------------------
    SPRIOR = {};
    SPRIOR{1} = @spriors_c; % function handle to SPriors YOU must provide!
    SPRIOR{2} = sprior_mu;
    SPRIOR{3} = sprior_cov;
else
	SPRIOR = {};
end


% ------------------------------------------------------
% ESTIMATE -- Building on TOP of IRIS
% ------------------------------------------------------
	% create a database
	rng = 1:100;
	dss = sstatedb(m, rng);  % SS ok only when loglik not evaluated
	% dss = actual database...

	% estimate the model 
	m = solve(m); % just to be sure it's been solved...

	% run the estimator
	[mstar est_out] = estimate_pp(m, rng, E, dss, SPRIOR, ESTOPTS);

	% Display posterior mode parameterization
    disp('Maximum likelihood estimates');
    disp(get(mstar,'parameters'));
    
    % Visualise prior distributions and posterior modes
    [pr,po,fig,ax,prlin,polin,blin,tit] = plotpp(E,est_out.P,'subplot',[4,4]);
    ftitle(fig,'Prior distributions and posterior modes');
      set(blin,'marker','.','markerSize',11);
      set([ax,tit],'fontSize',8);



% show some IRFs and see what happened
elist = {'SHK_RS_UNC','SHK_L_GDP_GAP','SHK_DLA_CPIXFE'}	  ;
vlist = {'DLA_CPIXFE','L_GDP_GAP' 'L_S','RS'} ;
vnams = {'Core Inflation','Output Gap', 'Nominal ER','Policy Rate'} ;
irf1  = srf(m, 1:50, 'select', elist,'size',1);
irf2  = srf(mstar, 1:50, 'select', elist,'size',1);

for i = 1 : numel(elist)
	f{i} = figure('name',strrep(elist{i},'_','\_'));
	for j = 1 : numel(vlist)	
	subplot(2,2,j)
		pp = plot([irf1.(vlist{j}){:,i} irf2.(vlist{j}){:,i}],'linewidth',2);
		set(pp(1),'color','b');
		set(pp(2),'color','r');
		title(sprintf('%s: %s ',strrep(vlist{j},'_','\_'),vnams{j}));
	end
	print(gcf(),'-depsc',sprintf('c_irf_%d.eps',i));
end

f = figure();
pp = plot([irf1.L_GDP_GAP{:,3} irf2.L_GDP_GAP{:,3}],'linewidth',2);
 set(pp(1),'color','b');
 set(pp(2),'color','r');
 title('Any effect?')
print(gcf(),'-depsc','fix_blimp.eps');

p1 = get(m,'params');
p2 = get(mstar,'params');

pnames = fieldnames(p1);
for i = 1 : 15%numel(pnames)
	fprintf('%20s %f %f \n',pnames{i},p1.(pnames{i}),p2.(pnames{i}));
end

% I stop here but no problem going forward...	  
return
 

% ------------------------------------------------------
% SAMPLE -- Building on TOP of IRIS
% ------------------------------------------------------

	% Run a plain-vanilla adjusted Random-Walk Metropolis
	nDraw = 5000;


	doRunMH = false;
	if doRunMH
		[dat] = teacharwm(est_out, nDraw, rng, dss, E, SPRIOR, ESTOPTS);
	else
		load('rwm_1.mat');
	end

	% Use IRIS to plot the marginal priors vs compound priors
	pnames = fieldnames(E);
	[pr,po,fig,ax,prlin,polin,blin,tit] = grfun.plotpp(E, x2param(est_out.xstar,pnames) ,dat.THETA);



	% For slides only-create structures with param structures
	% so I can use it for testing...
	pnames = fieldnames(E);
	ZPOS = {};
	for i = 1 : nDraw
		aux = struct();
		for j = 1 : numel(pnames)
			aux.(pnames{j}) = dat.THETA(j,i); 
		end
		ZPOS{i} = aux;
	end



% save the results for furhter use
save('rwm_2.mat','dat','est_out','ZPOS');


