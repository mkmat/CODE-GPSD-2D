function [r,c]=visualize_single_p_from_edges(L,v,vc,ro,rc,rp,rs,triangles,id,A,B,C,lenA,lenB,lenC,x,xx,p,MaxPoreRadius,triangles_for_triangle)
    figure; 
    add_material(xx,L,ro,rc);
    add_voronoi_vertices(L,v);
    add_voronoi_edges(v,vc);
    add_triangles(L,triangles,id,A,B,x);
    disp(['test particle center at p = (' num2str(p(1)) ',' num2str(p(2)) ')']);
    [r,c]=get_pore_quantities_from_edges(L,rs,rp,x,p,id,A,B,C,lenA,lenB,lenC,MaxPoreRadius,triangles_for_triangle);
    disp(['pore radius r = ' num2str(r) ', pore centered at c = (' num2str(c(1)) ',' num2str(c(2)) ')']); 
    add_pore(L,p,c,r,rp);

    disp('zoom out to see the replicated voronoi array');
    for f=3:-0.01:1; axis([-1 1 -1 1]*f*L/2); pause(0.001); end
