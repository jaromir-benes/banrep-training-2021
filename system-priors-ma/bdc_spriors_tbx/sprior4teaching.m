%-----------------------------------------------------------------------------------
% SYSTEM PRIOR LOSS FUNCTION -- FOR TEACHING PURPOSES ONLY
%-----------------------------------------------------------------------------------
%
% x 		-- parameters
% sp_means	-- means or first. param of the distribution
% sp_cov	-- cov. matrix, or second param of the distribution
% m			-- model object, solved with new |x| already
% E		    -- structure with IRIS-format marginal priors, ub's, lb',s
% db		-- database used for the estimation
% options	-- options structure. can have any user-defined junk

% NOTE:
% THIS IS WRITTEN AS A |CRITERION| FUNCTION, WHICH IS THEN (-1)* IN LOSS  FUN
%
%
%-----------------------------------------------------------------------------------
% MANDRLE@IMF.ORG, Michal Andrle, IMF Research Department
%-----------------------------------------------------------------------------------

function [crit] = sprior_tcvar2(x, sp_means, sp_cov, m, E, db, options)

	crit = 0;
	

	% ----------------------------------------------------------------
	% SPRIOR #1 :Prior about the sacrifice ratio of the model
	% ----------------------------------------------------------------
	%
	% Here, people have complete freedom to design any computations
	% they want, including endogenize/exogenize, etc.
	%
	mx = m;                   % create a temporary copy of the model
	pm = get(m,'params');     % get the parameters of the model we are using

	if pm.rho_D4L_CPI_TAR ~= 1.0
		pm.rho_D4L_CPI_TAR = 1.0; % now, make the TARGET a unit root, irregardless of the MODEL's parameterization...
		mx = assign(mx, pm);      % use the params
		mx = solve(mx);           % solve. Now, it will not be difference stationary but that's ok
	else
		% pass....
	end

	% run the disinflation scenario 
	irf_ = srf(mx, 1:100, 'select',{'SHK_D4L_CPI_TAR'},'size',-1);
	aux = cumsum(irf_.L_GDP_GAP{1:end,1});
	val = aux(end); % this is the value of cummulated gaps

	if ~isnan(val)
		% create the distribution with the mean and variance given in the driver
		sp1 = logdist.normal(sp_means(1), sp_cov(1,1));
		log_crit1 = sp1(val); % evaluate the restriction

	else
		error('Something went wrong... IRF for sacrifice ratio is NaN.\n');
	end
	% add to the criterion function
	crit = crit + log_crit1;
	
	% end of SPRIOR #1
	% ----------------------------------------------------------------




	% ----------------------------------------------------------------
	% SPRIOR #2: Prior on high-frequency component of inflation
	% ----------------------------------------------------------------



	% ----------------------------------------------------------------
	% SPRIOR #3: prior on convergence of all gap variables [pie, y, i] under four
	% ----------------------------------------------------------------




end 
