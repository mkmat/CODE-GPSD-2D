function s = shortest_distance_point_line(L,point,lineA,lineB)
    rel = fold(L,point-lineA); 
    lineC = lineB-lineA; 
    t = max(0,min(1,dot(lineC,rel)/sum(lineC.^2))); 
    s = norm(fold(L,lineA+t*lineC-point)); 