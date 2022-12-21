function code_G_PSD_2D_for_our_multidisk
close all

% this code calculates P(r|reff) in the first place, P(r;rp|rc) = P(r-rp|reff).
% p (absolute position of the test particle center), P (relative position)

L       = 1;        % box size
rc      = 0;        % material coating thickness
rp      = 0;        % probe particle radius
shots   = 500000;  % number of random shots to calculate the G-PSD
PSDbins = 1000;     % number of bins for the G-PSD
 
[N,L,ro,x] = create_our_multidisk

disp([num2str(N) ' particles']); 

% setup
[reff,rs,xx,v,vc,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,MaxPoreRadius,triangles_for_triangle]=PSD_preliminaries(N,L,ro,rc,rp,x);

% visualize the situation
figure; 
add_material(xx,L,ro,rc);
add_triangles(L,triangles,id,A,B,x);

% calculate the G-PSD using >shots< probe particle insertions
[r,cpusecs] = get_G_PSD_P_r_reff(N,L,x,rs,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,triangles_for_triangle,shots);
[radius,GPSD,GPSDcum]=show_PSD(rc,rp,MaxPoreRadius,r,PSDbins);