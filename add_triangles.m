function add_triangles(L,triangles,id,A,B,x)
    for j=1:triangles
        plot(x(id(j),1)+[0 A(j,1) B(j,1) 0],x(id(j),2)+[0 A(j,2) B(j,2) 0],'k','color',[1 1 1]*0.8); hold on; 
    end
    axis([-1 1 -1 1]*L/2);