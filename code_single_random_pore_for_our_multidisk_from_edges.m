function [r,c]=code_single_random_pore_for_our_multidisk_from_edges
close all

% create our multidisk situation with N=20 particles, choose coating
% thickness rc and probe particle radius rp randomly 

rp      = randi(10)/10*0.05;
rc      = randi(10)/10*0.05;
reff    = rc+rp; 

[N,L,ro,x] = create_our_multidisk;

% setup
[reff,rs,xx,v,vc,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,MaxPoreRadius,triangles_for_triangle]=PSD_preliminaries(N,L,ro,rc,rp,x);

% create random point p within allowed area
p = get_random_p(L,rs,x); 
% p = [-0.3 -0.2], 


% visualize the result
[r,c]=visualize_single_p_from_edges(L,v,vc,ro,rc,rp,rs,triangles,id,A,B,C,lenA,lenB,lenC,x,xx,p,MaxPoreRadius,triangles_for_triangle)
title(['r_o = ' num2str(ro) ' (black), r_c = ' num2str(rc) ' (dashed), r_p = ' num2str(rp) ' (red)']);