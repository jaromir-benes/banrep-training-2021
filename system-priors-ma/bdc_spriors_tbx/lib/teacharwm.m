% ----------------------------------------------------------------------
% TEACHARWM: Poor man's (teaching) Adjusted Random-Walk Metropolis (RWM)
% ----------------------------------------------------------------------
%
%
% This code is ILLUSTRATIVE. No adaptation, no parallel pre-fetching.
% Nothing is stored on hardrive, everything needs to fit into memory ;)
% This should make it easy to READ.
%
%
% Note: For efficient estimation, use the |SSMC.m| code 
%
% Contact: mandrle@imf.org, Michal Andrle (IMF RES)
% https://michalandrle.weebly.com/system-priors.html
% ----------------------------------------------------------------------
function [DAT] = teacharwm(pos, ndraws, rng, db, E, props, options)

    % the |pos| object has: xstar, P, H1, and , m

    % use the model parsed in IRIS
    m = pos.m;

    % initialize the kernel to evaluate [a function handle passed in]
    options.range = rng;
    fn = @(x)lossfun(x, m, E, db, props, options);

    % since this is small-scale, stay in memory...
    npar = numel(pos.xstar);
    THETA = nan(npar,ndraws);

    % initialize param vector and value of logPosterior in the mode
    oldTheta = pos.xstar;
    logPost  = (-1)*fn(oldTheta);

    % scaling coefficient for the Hessian
    sc = 0.5;
    burnin = max(50,floor(0.05*ndraws)); % use 5% or 100

    % use the Hessian info to get scaling
    [u_ s_ v_] = svd(pinv(pos.H1));
    V = u_*(s_.^(1/2));

    % Serial, in-memory implementation 
    num_accepted = 0;
    notDone = true;
    r = 0;

    fprintf('[Running plain-vanilla RMW sampling.]\n'); 
    while notDone
        % update the counter 
        r = r + 1;
    
        % draw from standard normal to 'walk the walk'
        u = randn(npar, 1);

        % get a new theta
        newTheta = oldTheta + sc*V*u;

        % check bounds [nested fun]
        withinBounds = doCheckBounds(newTheta);

        % if withinBounds 
        if withinBounds
            newLogPost = (-1)*fn(newTheta);

            % accept or not and store the results
            randomAcceptLevel = rand();
            alpha = min(1, max(0,exp(newLogPost - logPost)));
            doAccept = (randomAcceptLevel < alpha);

        else
            doAccept = false;
        end

        % acceptance step
        if doAccept
            num_accepted = num_accepted + 1;
            accept_rat   = num_accepted / r;
            logPost      = newLogPost;
            oldTheta     = newTheta;
        end

        % store the draw (stores either the old or the updated one)
        X(:,r) = oldTheta;

        % are we done
        if (r >= (ndraws + burnin))
            notDone = false;
        end

        
    end % end of the |while| loop


    % output data
    DAT = struct();
    DAT.m = m;
    DAT.THETA = X(:,burnin+1:end);
    DAT.accept_rat = accept_rat;
    DAT.fn = fn;

    % return   % end of |teacharwm| processing


    %% doCheckBounds
    % ------------------------------------------------------
    function [flag] = doCheckBounds(x)
        flag = true; 
        [x0 lb ub pr pNames] = prior2vect(E,m);

        % check lower bound
        if any(x < lb)
            flag = false;
            return;
        end

        % check upper bound
        if any(x > ub)
            flag = false;
            return;
        end
    end % doCheckBounds



end  % of teacharwm
