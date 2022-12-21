function [N,L,ro,x] = create_our_large_system

N       = 1000; 
L       = 1; 
phi     = 0.3; 
ro      = sqrt(phi/(N*pi))*L;   % N pi*ro^2 = phi L^2; 
x       = (rand(N,2)-0.5)*L; 
