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
	% constants & setup
	MAX_LOSS = 1e+10;

	crit = 0;


	% ----------------------------------------------------------------
	% SPRIOR #1: Example of nudging the calibration to avoid an output
    % incrase after a one-off cost-push shock
	% ----------------------------------------------------------------
	%
	% Here, people have complete freedom to design any computations
	% they want, including endogenize/exogenize, etc.

	% run the CPIXFE shock
	irf_ = srf(m, 1:100, 'select',{'SHK_DLA_CPIXFE'},'size',1);
	aux = (irf_.L_GDP_GAP{1:1,1});
	val = aux(end); % get the first period response

	if ~isnan(val)
		% create the distribution with the mean and variance given in the driver
		sp1 = logdist.normal(-0.005, 0.02);  % use Normal distribution to nudge it below zero [having it smooth is a good try] if your starting value is actually positive
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
