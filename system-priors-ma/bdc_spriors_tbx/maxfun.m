% user-defined function example for IRIS/SPRIORS
function [val] = maxfun(in)

	% squeeze the thing to work with
	xin = squeeze(in(1,1,:));

	% do some fancy calculations... like |max|
	val = max(xin);

	keyboard

end
