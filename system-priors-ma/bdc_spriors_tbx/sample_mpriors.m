%
% Sample from the mpriors. This is simple, you can make it more robust
%
% mandrle@imf.org
% 
%
% Note: Requires Stat Toolbox for beta/gamma/ingamma... or a hack...

function [X Z] = sample_mpriors(E, N)
    list = fieldnames(E);
    X = nan(numel(list),N);

    for i = 1 : numel(list)
        X(i,:) = E.(list{i}){4}([],'draw',1,N);
    end 

	% convenience only...
	Z = {};
	for j = 1 : N
		for i = 1 : numel(list)
			Z{j}.(list{i}) = X(i,j);
		end
	end

end 
