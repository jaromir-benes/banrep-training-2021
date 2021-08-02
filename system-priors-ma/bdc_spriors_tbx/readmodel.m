%%%%%%%%
%%% CALIBRATION FOR THE CZECH REPUBLIC
%%%%%%%%
function [m,p,mss] = readmodel(filter)

%% Filtration on/off
% filter = true - Kalman filter ON
% filter = false - Kalman filter OFF

p.filter = filter;

%% Typical and specific parameter values be used in calibrations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Aggregate demand equation (the IS curve)
% L_GDP_GAP = b1*L_GDP_GAP{-1} - b2*MCI + b3*L_GDP_RW_GAP + SHK_L_GDP_GAP;

%% Real monetary conditions index (mci)
% MCI = b4*RR_GAP + (1-b4)*(-L_Z_GAP);

%output persistence;
%b1 varies between 0.1 (extremely flexible) and 0.95(extremely persistent)
p.b1 = 0.7;

%policy passthrough (the impact of monetary policy on real economy); 
%b2 varies between 0.1 (low impact) to 0.5 (strong impact)
p.b2 = 0.2; 

%the impact of external demand on domestic output; 
%b3 varies between 0.1 and 0.7
p.b3 = 0.3; 

%the weight of the real interest rate and real exchange rate gaps in MCI;
%b4 varies from 0.3 to 0.8
p.b4 = 0.7;

%persistence in credit premium 
p.b5 = 0.7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 2. Aggregate supply equation (the Phillips curve)
% DLA_CPIXFE =  a1*DLA_CPIXFE{-1} + (1-a1)*(DLA_CPIXFE{1}) + a2*RMC + SHK_DLA_CPI;
% DLA_CPIXFE =  a1*DLA_CPIXFE{-1} + (1-a1)*(DLA_CPI{1} + DLA_RPXFE_BAR{1}) + a2*RMC + SHK_DLA_CPIXFE;

%% Real marginal cost (rmc)
% RMC = a3*L_GDP_GAP + (1-a3)*(L_Z_GAP- L_RPXFE_GAP);

% inflation persistence; 
% a1 varies between 0.4 (implying low persistence) to 0.9 (implying high persistence)
p.a1 = 0.5; 

% policy passthrough (the impact of rmc on inflation); 
% a2 varies between 0.1 (a flat Phillips curve and a high sacrifice ratio) 
% to 0.5 (a steep Phillips curve and a low sacrifice ratio)
p.a2 = 0.1;

% the ratio of imported goods in firms' marginal costs (1-a3); 
% a3 varies between 0.9 for a closed economy to 0.5 for an open economy
p.a3 = 0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Food prices
% DLA_CPIF = a21*DLA_CPIF{-1} + (1-a21)*(DLA_CPIF{1}) + a22*RMC_F + SHK_DLA_CPIF
% DLA_CPIF = a21*DLA_CPIF{-1} + (1-a21)*(DLA_CPI{1} + DLA_RPF_BAR{1}) + a22*RMC_F + SHK_DLA_CPIF;

%% Real Marginal Costs
% RMC_F = a23*(L_RWFOOD_GAP + L_Z_GAP - L_RPF_GAP) + (1-a23)*L_GDP_GAP;

% persistence; 
% a21 varies between 0.1 (implying low persistence) to 0.9 (implying high persistenceI)
p.a21 = 0.5;

% passthrough (the impact of world food prices and the business cycle on food prices); 
% a22 varies between 0.1 (low passthrough) 
% to 0.5 (high passthrough)
p.a22 = 0.2;

% the impact of world food prices and the business cycle on food prices; 
% a23 is usually high, e.g. 0.7-0.9 Then (1-a23) coefficient on business cycle output gap is low (limited impact of the business
% cycle on food prices)
p.a23 = 0.25; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Energy prices
% DLA_CPIE = a31*DLA_CPIE{-1} + (1-a31)*(DLA_CPIE{1}) + a32*RMC_E + SHK_DLA_CPIE;
% DLA_CPIE = a31*DLA_CPIE{-1} + (1-a31)*(DLA_CPI{1} + DLA_RPE_BAR{1}) + a32*RMC_E + SHK_DLA_CPIE;

%% Real Marginal Costs -- Energy prices
% RMC_E = L_RWOIL_GAP + L_Z_GAP - L_RPE_GAP;
% persistence; 
% a31 varies between 0.9 (low persistence) to 0.1 (high persistence)
p.a31 = 0.5; 

% passthrough from world oil prices and the exchange rate on domestic oil prices; 
% a32 varies between 0.1 (low passthrough) to 0.5 (high passthrough)
p.a32 = 0.2; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Headline inflation
% L_CPI = w_CPIE*L_CPIE + w_CPIF*L_CPIF + (1-w_CPIE-w_CPIF)*L_CPIXFE;

% weight of food prices in the CPI basket
p.w_CPIF = 0.25;

%weight of oil prices in the CPI basket
p.w_CPIE = 0.15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Uncovered Interest Rate Parity (UIP)

%% A. UIP with a backward-looking element ("persistent" exchange rate)
% L_S = (1-e1)*L_S{+1} + e1*(L_S{-1} + 2/4*(D4L_CPI_TAR - SS_DLA_CPI_RW + DLA_L_Z_BAR)) + (- RS + RS_RW + PREM)/4 + SHK_L_S;
% Setting e1 equal to 0 reduces the equation to the simple UIP
p.e1 = 0.2;

%% B. dirty float/managed float/peg
% L_S = h2*(L_S{-1}+DLA_S_TAR/4)+(1-h2)*((1-e1)*L_S{+1} + e1*(L_S{-1} + 2/4*(D4L_CPI_TAR - SS_DLA_CPI_RW + DLA_L_Z_BAR)) + (- RS + RS_RW + PREM)/4) + SHK_L_S;
% Setting h2 equal to 0 implies float based on the UIP, h2 equal to 1 means
% managed FX following target appreciation.
p.h2 = 0;

%% C. UIP when the exchange rate is managed to meet the inflation objective
% Set h2 different from zero. See discussion related to Section B and
% parameter h2. On the top of that set f2 and f2 different from zero.

% DLA_S_TAR = f1*DLA_S_TAR{-1} + (1-f1)*(D4L_CPI_TAR - ss_DLA_CPI_RW + DLA_Z_BAR + f2*(D4L_CPI-D4L_CPI_TAR) + f3*L_GDP_GAP) + SHK_DLA_S_TAR;
% L_S_TAR = L_S_TAR{-1} + DLA_S_TAR/4;
p.f1 = 0.5;
p.f2 = 0;
p.f3 = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Monetary policy reaction function 

%% A. The standard rule
% RN = g1*RN{-1} + (1-g1)*(RNNEUTRAL + g2*(D4L_CPI{+3} - D4L_CPI_TAR{+3}) + g3*L_GDP_GAP) + SHK_RN;

% policy persistence; 
% g1 varies from 0 (no persistence) to 0.8 ("wait and see" policy)
p.g1 = 0.75; 

% policy reactiveness: the weight put on inflation by the policy maker); 
% g2 has no upper limit but must be always higher then 0 (the Taylor principle)
p.g2 = 0.5; 

% policy reactiveness: the weight put on the output gap by the policy maker); 
% g3 has no upper limit but must be always higher then 0
p.g3 = 0.25;

%% B. The rule modified for imperfect control over the domestic money market
%% (use if the central bank stabilizes the exchange rate by FOREX interventions)

% RS = h1*(4*(L_S{+1} - L_S) + RS_RW + PREM) + (1-h1)*(g1*RS{-1} + (1-g1)*(RSNEUTRAL + g2*(D4L_CPI{+3} - D4L_CPI_TAR{+3}) + g3*L_GDP_GAP)) + SHK_RS;

% degree to which the central bank does not control domestic money market
p.h1 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 5. Speed of convergence of selected variables to their trend values.
% Used for risk ppremium, trends, foreign variables and world commodity prices, 

% relative prices
p.rho_DLA_RPF_BAR   = 0.75;
p.rho_DLA_RPXFE_BAR = 0.75;

% persistent shock to risk premium
% SHKN_PREM = rho_SHKN_PREM*SHKN_PREM{-1} + SHK_PREM;
p.rho_SHKN_PREM = 0.5;

% persistence in convergence of trend variables to their steady-state levels
% applies for:   DLA_GDP_BAR, DLA_Z_BAR, RR_BAR and RR_RW_BAR
% example:
% DLA_Z_BAR   = rho_DLA_Z_BAR*DLA_Z_BAR{-1}   + (1-rho_DLA_Z_BAR)*ss_DLA_Z_BAR   + SHK_DLA_Z_BAR and
% DLA_GDP_BAR = rho_DLA_GDP_BAR*DLA_GDP_BAR{-1} + (1-rho_DLA_GDP_BAR)*ss_DLA_GDP_BAR + SHK_DLA_GDP_BAR;
p.rho_DLA_Z_BAR   = 0.8;
p.rho_DLA_GDP_BAR = p.rho_DLA_Z_BAR;
p.rho_RR_BAR      = p.rho_DLA_Z_BAR;
p.rho_RR_RW_BAR   = p.rho_DLA_Z_BAR;

% persistence in foreign GDP 
% L_GDP_RW_GAP = h2*L_GDP_RW_GAP{-1} + SHK_L_GDP_RW_GAP;
p.rho_L_GDP_RW_GAP = 0.8;

% persistence in foreign interest rates (and inflation);
%RS_RW = rho_RS_RW*RS_RW{-1} + (1-rho_RS_RW)*(RR_BAR + DLA_CPI_RW) + SHK_RS_RW;
p.rho_RS_RW      = 0.8;
p.rho_DLA_CPI_RW = p.rho_RS_RW;

% persistence in cross exchange rate and world food and oil prices
% example:
p.rho_DLA_S_CROSS    = 0.5;
p.rho_DLA_RWOIL_BAR  = 0.5;
p.rho_L_RWOIL_GAP    = 0.5;
p.rho_DLA_RWFOOD_BAR = 0.5;
p.rho_L_RWFOOD_GAP   = 0.5;


% Speed of inflation target adjustment to the medium-term target (higher values mean slower adjustment)
% D4L_CPI_TAR = f1*D4L_CPI_TAR{-1} + (1-f1)*ss_D4L_CPI_TAR + SHK_D4L_CPI_TAR;
p.rho_D4L_CPI_TAR = 0.5;
%p.rho_D4L_CPI_TAR = 1.0; % MA: TODO this must be 1 for the experiments

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The inflation target and other observed economic trends
% These "steady-state" values are all calibrated

% Foreign trend inflation or inflation target
p.ss_DLA_CPI_RW = 2;

% Trend level of domestic real interest rate 
p.ss_RR_BAR = 0.5; %0.5; 

% Trend change in the real ER (negative number = real appreciation)
p.ss_DLA_Z_BAR = -1.5; 

% Potential output growth
p.ss_DLA_GDP_BAR = 2.5; %1

% Trend level of foreign real interest rate
p.ss_RR_RW_BAR = 0.75; %0.5;

% Domestic inflation target
p.ss_D4L_CPI_TAR = 2;  

% commodity price trends
p.ss_DLA_RWOIL_BAR  = 5;
p.ss_DLA_RWFOOD_BAR = 0;

% relative price trends
p.ss_DLA_RPXFE_BAR = -1.5;
p.ss_DLA_RPF_BAR   = 0;


%% Model solving--a brief description of commands
% Command 'model' reads the text file 'model.mod' (contains the model's
% equations), assigns the parameters and trend values preset in the database
% 'p' (see readmodel) and transforms the model for the matrix algebra. 
% Transformed model is written in the object 'm'. 

% m = model('model.model','linear=',false,'assign',p);
%m = model('model.model','linear=',false,'assign',p);
m = model('model.model','linear=',true,'assign',p);

m = solve(m);
mss = get(m,'sstate');


% Command 'sstate' takes the transformed model in object 'm', calculates the model's
% steady-state and writes everything back in the object 'm'. Typing 'mss' in
% Matlab command window provides the steady-state values.
m = sstate(m,'growth',true,'MaxFunEvals',2000);
mss = get(m,'sstate');

%% Check steady state
[flag,discrep,eqtn] = chksstate(m);

if ~flag
  error('Equation fails to hold in steady state: "%s"\n', eqtn{:});
end

% Command 'solve' takes the model saved in object 'm' and solves the model
% for its reduced form (Blanchard-Kahn algorithm). The reduced form is again  
% written in the object 'm'   
%
m = solve(m);

if mss.L_GDP_GAP~=0 | mss.L_Z_GAP~=0 | mss.L_RPXFE_GAP~=0 | mss.L_RPF_GAP~=0
    disp('WARNING')
end
