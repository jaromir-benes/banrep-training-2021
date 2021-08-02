%% --------------------------------------------------------------------
%% set marginal priors for the model [purely illustrative purposes]
%% --------------------------------------------------------------------
%
% Michal Andrle
% mandrle@imf.org, michal_andrle@yahoo.com
%
% august 2021
%% --------------------------------------------------------------------
%
%
% INPUTS: 
%
%   P       -- parameter structure with MEAN params calibration. I will use
%               this info either as a MEAN or MODE for the prior...
%
% OUTPUTS:
%   E       -- IRIS estimation mprior structure
%

function [E ] = set_mpriors(P, varargin)

    % Setting Priors only for DYNAMICAL parameters

    % IRIS formatting for MPRIORS
    %E.rho_gx1   = {P.rho_gx1,   0, 1, logdist.beta(0.80,0.15) }

    % scaling
    sc = 1;

    E = struct();

    %% Output gap

    % output persistence
    E.b1    =  {P.b1, -Inf, Inf, logdist.normal(P.b1, sc * 0.15)};
    % MCI load
    E.b2    =  {P.b2, -Inf, Inf, logdist.normal(P.b2, sc * 0.10)};
    % external demand
    E.b3    =  {P.b3, -Inf, Inf, logdist.normal(P.b3, sc * 0.10)};
    % RR weight in MCI
    E.b4    =  {P.b4, -Inf, Inf, logdist.normal(P.b4, sc * 0.10)};
    % cred. premium RHO
    E.b5    =  {P.b5, -Inf, Inf, logdist.normal(P.b5, sc * 0.10)};


    %% PCurve
    % lag
    E.a1    =  {P.a1, -Inf, Inf, logdist.normal(P.a1, sc * 0.10)};
    % RMC load
    E.a2    =  {P.a2, -Inf, Inf, logdist.normal(P.a2, sc * 0.05)};
    % Output gap weight in RMC
    E.a3    =  {P.a3, -Inf, Inf, logdist.normal(P.a3, sc * 0.10)};

    %% Food Pie
    % lag
    E.a21    =  {P.a21, -Inf, Inf, logdist.normal(P.a21, sc * 0.10)};
    % RMC_F load
    E.a22    =  {P.a22, -Inf, Inf, logdist.normal(P.a22, sc * 0.05)};
    % RPF weight in RMC_F
    E.a23    =  {P.a23, -Inf, Inf, logdist.normal(P.a23, sc * 0.05)};


    %% Energy Price Inflation
    % lag
    E.a31    =  {P.a31, -Inf, Inf, logdist.normal(P.a31, sc * 0.10)};
    % RMC load
    E.a32    =  {P.a32, -Inf, Inf, logdist.normal(P.a32, sc * 0.10)};


    %% UIP bwl
    E.e1     =  {P.e1, -Inf, Inf, logdist.normal(P.e1, sc * 0.05)};


    %% Standard MP Rule
    % persistence
    E.g1     =  {P.g1, -Inf, Inf, logdist.normal(P.g1, sc * 0.10)};
    % weigth on PIE
    E.g2     =  {P.g2, -Inf, Inf, logdist.normal(P.g2, sc * 0.10)};
    % weight on gap
    E.g3     =  {P.g3, -Inf, Inf, logdist.normal(P.g3, sc * 0.10)};



    %% Inconsistent foreign shocks. Tread lightly...
    % Foreign gap persistence
    E.rho_L_GDP_RW_GAP     =  {P.rho_L_GDP_RW_GAP, -Inf, Inf, logdist.normal(P.rho_L_GDP_RW_GAP, sc * 0.10)};


end
