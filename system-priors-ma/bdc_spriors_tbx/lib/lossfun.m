function [loss] = lossfun(x, m, E, db, props, options)
% criterion function to |minimize|
% Inputs: 	m - model, E - priors, db -- database, props -- properties priors
% 			x - vector of coefficients
%
% NOTE: The loss function optimum is at its MINIMUM. 
% 		It is log-lik, log-prior & log-properties.
%
% 
%
% Michal Andrle IMF Research Dept [mandrle@imf.org, michal_andrle@yahoo.com]
% https://michalandrle.weebly.com/system-priors.html
%
% -------------------------------------------------------------------
% This is a brute-force attach via finite-differences. 
% -------------------------------------------------------------------
	
	% constants & setup
	MAX_LOSS = 1e+10;

	% initialize the components of the loss fun
	loss = 0;
		lKalman = 0;
		lPrior	= 0;
		lProps	= 0;	

	% parameter names
	pnames = fieldnames(E);

 
	% -------------------------------------------------------
	% Solve the Model with the new parameters
	% -------------------------------------------------------
   	p_ = x2param(x,pnames);
   	m = assign(m,p_);

   	warning('off');
   		m = solve(m);
   	warning('on');

    if ~issolved(m)
   		if strcmpi(options.noSolve,'stop')
   			error('The model cannot be solved for this parameterization.\n');
   		else
   			loss = MAX_LOSS; % impose large penalty
			%warning('Not solving...\n');
   			return;
   		end
   	end 


	% -------------------------------------------------------
	% evaluate the |x| using marginal priors (logdist package)
	% -------------------------------------------------------
	lPrior = 0;
	if options.do_prior
		for j = 1 : numel(pnames)
			itsName = pnames{j};
			lPrior = lPrior - (E.(itsName){4}(x(j)));
			if isinf(lPrior)
				loss = MAX_LOSS;
				return;
			end
		end
	end

	% -------------------------------------------------------
	% evaluate the |system priors| function (fh_props is a fn handle)
	% -------------------------------------------------------
	if options.do_spriors
		if isempty(props)
			lProps = 0;
			warning('System Priors evaluated...but uninitiated');
		else
			fh_props  	= props{1};
			f_mean		= props{2};
			f_cov		= props{3};
			% evaluate the function
			%try
			   lProps = (-1)*fh_props(x, f_mean, f_cov, m, E, db, options);
		    %catch
			%   warning('lossfun:: sytem priors throwed up errors...');
			%   loss = MAX_LOSS;
			%   return;
		   %end
		end
		if isinf(lProps)
			loss = MAX_LOSS;
			return;
		end
	end

	% -------------------------------------------------------
	% Run the Kalman filter with the parameters
	% -------------------------------------------------------
	if options.do_lik
    	% evaluate a |MINUS-LOGLIK| in a time domain
	    [val_ V_ F_ PE_ DELTA_] = loglik(m,db,options.range);
        
	    lKalman = val_;
	    if options.debug == true
	     	val_
	    end   

	end

	% -------------------------------------------------------
	% full criterion function value
	% -------------------------------------------------------
	loss = lKalman + lPrior + lProps;


end % of the main function




