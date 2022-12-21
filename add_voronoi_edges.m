function add_voronoi_edges(v,vc)
    for j=1:length(vc)
        plot([v(vc{j},1);v(vc{j}(1),1)],[v(vc{j},2);v(vc{j}(1),2)],'b.-'); hold on; 
    end