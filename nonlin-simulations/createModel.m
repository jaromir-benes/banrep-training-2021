%% Create and calibrate model object 


%% Clear workspace

close all
clear
iris.required(20210802)

if ~exist("mat", "dir")
    mkdir mat
end


%% Read model source files and create model object

m = Model.fromFile([
    "model-source/fiscal.model"
    "model-source/macro.model"
    "model-source/world.model"
], "growth", true);


%% Calibrate model 

p = struct();
p = calibrate.macro(p);
p = calibrate.world(p);
p = calibrate.fiscal(p);

m = assign(m, p);


%% Calculate steady state and first-order solution

m.y = 1;
m = steady(m, blocks=false, fixLevel="y");

checkSteady(m);

m = solve(m);

table( ...
    m, ["steadyLevel", "steadyChange", "form", "description"] ...
    , "round", 8 ...
    , "writeTable", "steadyState.xlsx" ...
)



%% Save model to mat file 

save mat/createModel.mat m

