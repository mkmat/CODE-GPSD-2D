function code_G_PSD_2D_for_random_material
close all

% this code calculates P(r|reff) in the first place, P(r;rp|rc) = P(r-rp|reff).
% p (absolute position of the test particle center), P (relative position)

N       = 30;       % number of material circles
L       = 100;      % box size
ro      = 5;        % radius of material circles
rc      = 0.03;     % material coating thickness
rp      = 2;        % probe particle radius
shots   = 50000;    % number of random shots to calculate the G-PSD
PSDbins = 1000;     % number of bins for the G-PSD

x       = create_random_material_centers(N,L,ro);      
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