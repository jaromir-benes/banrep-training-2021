
close 
clear all

m = Model.fromFile([
    "model-source/macro.model"
    "model-source/fiscal.model"
    "model-source/world.model"
], growth=true);

p = struct();
p = calibrate.macro(p);
p = calibrate.world(p);

m = assign(m, p);
m.ss_yg_to_y = 0.20;
m.ss_bg_to_ny = -0.50;
m.c1_vg_to_ny = 0.5;

m = steady(m);

checkSteady(m);

m = solve(m);

