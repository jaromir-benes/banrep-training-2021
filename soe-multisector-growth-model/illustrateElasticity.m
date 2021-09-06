
close all
clear 

e = Model.fromFile("model-source/production-elasticity-example.model");

e.gamma = 0.5;
e.xi = 3;
e.beta = 0.95;
e.epsilon = 0.5;

e = steady(e, "blocks", false);
e = solve(e);

table(e, "steadyLevel")


d = steadydb(e, 1:20);

ch = databank.Chartpack();
ch.Range = 0:10;
ch.Round = 8;
ch < ["pa", "pb", "y", "[a1,a2,a3]", "[b1,b2,b3]", "[py1,py2,py3]", "[y1,y2,y3]"];


% Permanent unexpected
d1 = d;
d1.shk_pa(1) = 0.10;
s1 = simulate(e, d1, 1:20, "method", "stacked", "prependInput", true);
draw(ch, s1);
visual.heading("Permanent unexpected");


% Temporary unexpected
d2 = d;
d2.shk_pa(1) = 0.10;
d2.shk_pa(2) = -0.10;
s2 = simulate(e, d2, 1:20, "method", "stacked", "prependInput", true);
draw(ch, s2);
visual.heading("Temporary unexpected");


% Permanent expected
d3 = d;
d3.shk_pa(5) = 0.10;
s3 = simulate(e, d3, 1:20, "method", "stacked", "prependInput", true);
draw(ch, s3);
visual.heading("Permanent expected");


% Permanent expected but not actually materialized
d4 = d;
d4.shk_pa(5) = 0.10 - 0.10i;
s4 = simulate(e, d4, 1:20, "method", "stacked", "prependInput", true);
draw(ch, s4);
visual.heading("Permanent expected but not materialized");

