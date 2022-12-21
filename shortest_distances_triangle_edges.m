function s = shortest_distances_triangle_edges(L,x,id,absA,absB,triangle_no)
    x_triangle = x(id(triangle_no),:); 
    absA_triangle = absA(triangle_no,:);
    absB_triangle = absB(triangle_no,:);

    % here one may restrict the search to absA,absB in the MaxPoreRadius
    % neighborhood of x_triangle etc. for example via a neighbor list

    s1 = shortest_distances_point_lines(L,x_triangle,absA,absB);
    s2 = shortest_distances_point_lines(L,absA_triangle,absA,absB);
    s3 = shortest_distances_point_lines(L,absB_triangle,absA,absB);
    s  = min(s1,min(s2,s3)); 
    