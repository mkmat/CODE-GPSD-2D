function triangle_nos = find_edges_for_triangle_speedversion(L,rs,x,id,lenA,lenB,absA,absB,triangle_no)
    maxmax          = max(lenA,lenB); 
    s               = shortest_distances_triangle_edges(L,x,id,absA,absB,triangle_no);
    triangle_nos    = find(maxmax-rs>=s); 