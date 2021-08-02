function [p] = x2param(x,pnames)
% put vector |x| into structure with |pnames|	
	p = struct();
	for i = 1 : numel(pnames)
		p.(pnames{i}) = x(i);
	end
end
