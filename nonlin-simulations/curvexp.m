function y = curvexp(x, alpha)

if isscalar(alpha) && numel(x)>1
    alpha = repmat(alpha, size(x));
end

y = x;
inx = alpha~=0;
if nnz(inx)>0
    y(inx) = (1./alpha(inx)) .* (exp(alpha(inx).*x(inx)) - 1);
end

end%


