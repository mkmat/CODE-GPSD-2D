function [N,L,ro,x] = create_our_multidisk

L       = 1; 
ro      = 0.1; 
x = [ 0.3491  0.4572;...
      0.4340 -0.0146;...
      0.1787  0.3003;...
      0.2577 -0.3581;...
      0.2431 -0.0782;...
     -0.1078  0.4157;...
      0.1555  0.2922;...
     -0.3288  0.4595;...
      0.2060  0.1557;...
     -0.4682 -0.4643];
N = length(x(:,1)); 