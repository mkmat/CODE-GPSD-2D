function [radius,GPSD,GPSDcum] = code_G_PSD_2D_for_user_defined_system(L,x,ro,rc,rp,shots,PSDbins)
close all

% user has to specify box size L and N material center coordinates x(1..N,1:2) as well as the
% radius ro of a material circle,
% thickness rc of the material coating
% radius rp of the probe circle
% and to specify the quality and resolution of the G-PSD
% shots: number of random shots to calculate the G-PSD
% PSDbins: number of bins for the G-PSD (recommended: 1000)

% an example is given below within the function: example_on_how_to_use_this_code

% check input provided by user and determine N from x
if ((ro<0)|(ro>L/2)),   disp('the material circles are too large or the box too small'); end
if rp<0,                disp('rp must be semipositive'); end
N = length(x(:,1));     disp([num2str(N) ' particles']); 

% setup
[reff,rs,xx,v,vc,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,MaxPoreRadius,triangles_for_triangle]=PSD_preliminaries(N,L,ro,rc,rp,x);

% visualize the situation 
if N<1000
    disp('started plotting ..'); 
    figure; 
    add_material(xx,L,ro,rc);
    add_triangles(L,triangles,id,A,B,x);
    disp('finished plotting');
else
    disp(['skip plotting for N > ' num2str(1000) ' particles']);
end

% calculate the G-PSD using >shots< probe particle insertions
[r,cpusecs] = get_G_PSD_P_r_reff(N,L,x,rs,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,triangles_for_triangle,shots);
[radius,GPSD,GPSDcum]=show_PSD(rc,rp,MaxPoreRadius,r,PSDbins);


function example_on_how_to_use_this_code

    % just copy and paste the following lines at once into the Command Window and press return

    L  = 1; 
    dx = 0.1; 
    [X,Y] = meshgrid(-L/2:dx:(L/2-dx),-L/2:dx:(L/2-dx));
    remove = find(sqrt(X.^2+Y.^2)<0.3); 
    X(remove) = [];
    Y(remove) = [];
    x = [X(:) Y(:)];        % matrix with N rows and 2 colunms

    ro = dx/2;
    rc = 0;
    rp = 0;

    shots = 10000;
    PSDbins = 100; 

    [radius,GPSD,GPSDcum] = code_G_PSD_2D_for_user_defined_system(L,x,ro,rc,rp,shots,PSDbins);