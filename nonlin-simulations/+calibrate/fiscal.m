function x = fiscal(x)

x.ss_yg_to_y = 0.20;
x.ss_nga_to_4ny = -0.50;
x.kappa = 0.5;

x.c1_q = 0.5/400;
x.c2_q = 0.10;
x.c3_q = -1.2;
x.c4_q = 0 - x.c1_q;
x.c5_q = 20/400 - x.c1_q;

x.c0_vg_to_ny = 0.95;
x.c1_vg_to_ny = 0.2;
x.c0_yg = 0.8;
x.c1_yg = 0.1;

end%

