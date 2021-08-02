%% Illustrate filter frequency response function using HP 


%% Clear workspace 

close all
clear
iris.required(20210802)


%% Read state space model of HP filter 

hp = Model.fromFile("model-source/hp.model", "linear", true);
hp = solve(hp);

% Parameterize lambda
hp.std_shock_gap = 40;


%% Run filter on random data 

d.x = Series(qq(2010,1), cumsum(randn(40,1)));

[~, f] = filter(hp, d, getRange(d.x), "meanOnly", ~true, "initUnit", "approxDiffuse");
[~, f2] = filter(hp, d, getRange(d.x), "meanOnly", ~true);

d.hpf_trend = hpf(d.x, "lambda", @auto);


%% Calculate filter frequency response function 

freq = 0.01:0.001:pi;
per = 2*pi./freq;
q = ffrf(hp, freq);

trendGain = abs(q("trend", "x", :));
trendGain = reshape(trendGain, 1, [ ]);

plot(freq, trendGain);
xline( 2*pi/10, "color", "black", "lineWidth", 1, "label", "10per");

