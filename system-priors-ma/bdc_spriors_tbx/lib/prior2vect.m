function [x lb ub pr names] = prior2vect(E,m)
% put the prior into vectors

% parameter names
names = fieldnames(E);

% fill initial value, lower bound, upper bound and priors
[x lb ub] = deal(nan(numel(names),1));
pr = cell(numel(names),1);

for i = 1 : numel(names)
	itsName = names{i};

	x(i)  = E.(itsName){1}	;
	lb(i) = E.(itsName){2}	;
	ub(i) = E.(itsName){3}	;
	pr{i} = E.(itsName){4}  ;
end

if nargin > 1
% if the model is available, initialize NaNs with its params
	P = get(m,'parameters');
	for i = 1 : numel(names)
		if isnan(x(i))
			x(i) = P.(names{i});
		end
	end
end


end % of the function
