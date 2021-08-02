function [X] = extract_irf(SM, varnames, ix)

	ns = numel(SM);
	np = length(SM{1}.(varnames{1}){0:end,ix});

	X = nan(np,ns,numel(varnames));

	for i = 1 : ns
		for j = 1 : numel(varnames)
			aux = SM{i}.(varnames{j}){0:end,ix};
			X(:,i,j) = aux;
		end
	end


end
