%% Compare autocovariance functions of stationarized and unit-root models
%
% In this m-file, we show that the autocovariance functions implied by the
% unit-root model and its stationarized version are identical.
%


%% Clear workspace 
%
% Clear all variables, close all figure windows, clear command window, and
% check the IrisT version.
%

close all
clear

load mat/createModels.mat m1 m2 m3


%% Calculate the autocovariance function
%
% Compute the autocovariance function up to first order (i.e. t-1 lag).
% Note that the variance-covariance of unit-root variables in models `m2`
% and `m3` (i.e. `Y`, `C`, `I`, `K`, `A`) is infinity.
%

c1 = acf(m1, "Order", 1);
c2 = acf(m2, "Order", 1);
c3 = acf(m3, "Order", 1);

size(c1)
size(c2)
size(c3)


%
% Display the contemporaneous covariances:
%

c1(:, :, 1)
c2(:, :, 1)
c3(:, :, 1)

%
% Display the first-order autocovariance matrix:
%

c1(:, :, 2)
c2(:, :, 2)
c3(:, :, 2)


%% Select subset of stationary variables
%
% Compare the autocovariance function of a subset of stationary variables:
% for instance, `y = Y/A`, `c = C/A`, and `r`. The size of the resulting
% matrices `c1`, `c2`, `c3`, and the ordering of the veriables in their
% rows and columns will be now identical.
%
% The differences come from rounding errors only.
%

listStationary = ["y", "c", "r"];
c1 = select(c1, listStationary);
c2 = select(c2, listStationary);
c3 = select(c3, listStationary);

c1 - c2 %#ok<NOPTS, *MNEFF>
c1 - c3 %#ok<NOPTS>

maxabs(c1, c2)
maxabs(c1, c3)

access(m2, "is-stationary")

