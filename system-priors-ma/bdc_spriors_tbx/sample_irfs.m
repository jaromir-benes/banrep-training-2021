%% -------------------------------------------------
% Simulate the IRFs 
%% -------------------------------------------------
%
% Inputs:
%	m -- iris model, list - list of shocks, Z -- cell of param struct draws
%   T -- range or numbe of periods
%
% Outputs:
%   SM -- cell of IRF structures
%
% 	mandrle@imf.org, December 2017
%% -------------------------------------------------
function [SM bs_ nFails ] = sample_irfs(mm, list, Z, T)

	nz = numel(Z);
	SM = cell(nz,1);
	
	if isscalar(T)
		rng = 1 : T;
	else 
		rng = T;
	end

	% track fails
	nFails = 0;

	% do the zero shock base
	%bs_ = srf(mm, rng, 'select',list,'size',0);
	bs_ = srf(mm, rng, 'select',list);

	fprintf('Sampling %d IRFs... ', nz);
	% do the irfs
	for i = 1 : nz
		mm = assign(mm, Z{i});
		try
			mm = solve(mm,'error',true);
			SM{i} = srf(mm, rng, 'select',list);
		catch
			nFails = nFails + 1;
			SM{i} = bs_; % pass no shock solution
			%fprintf('Not solving\n');
		end
	end

	fprintf('IRF Sampling Fail rate: %f.\n',nFails/nz);

end 
