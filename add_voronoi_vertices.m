function add_voronoi_vertices(L,v)
    plot(v(:,1),v(:,2),'k.','markerfacecolor',[0 0 0]); axis equal; axis([-1 1 -1 1]*L/2);
