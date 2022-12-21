function code_G_PSD_2D_for_our_benchmark
close all

% create our benchmark situation with a single particle, choose coating
% thickness rc and probe particle radius rp randomly 

rp      = randi(10)/10*0.2;
rc      = randi(10)/10*0.2;
reff    = rc+rp; 

shots   = 200000;
PSDbins = 1000; 

[N,L,ro,x]=create_our_benchmark;  % using the user-specified rc and rp 

% setup
[reff,rs,xx,v,vc,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,MaxPoreRadius,triangles_for_triangle]=PSD_preliminaries(N,L,ro,rc,rp,x);

% calculate and plot the G-PSD and cumulative G-PSD
[r,cpusecs] = get_G_PSD_P_r_reff(N,L,x,rs,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,triangles_for_triangle,shots);
[radius,GPSD,GPSDcum]=show_PSD(rc,rp,MaxPoreRadius,r,PSDbins);

% add figure title
subplot(1,2,1); title(['benchmark r_p=' num2str(rp) ', r_c=' num2str(rc) ', ' num2str(shots) ' shots'])

% add analytic result for comparison
subplot(1,2,1);
[radius,V,GPSD,GPSDcum]=benchmark_analytic(rc,rp,PSDbins);
semilogy(radius,GPSD,'g--'); 
legend('Voronoi-based','max. pore radius','analytical','location','best'); legend boxoff; 
subplot(1,2,2);
[radius,V,GPSD,GPSDcum]=benchmark_analytic(rc,rp,PSDbins);
semilogy(radius,GPSDcum,'g--'); 
legend('Voronoi-based','max. pore radius','analytical','location','best'); legend boxoff; 