function s = shortest_distance_line_line(L,line1A,line1B,line2A,line2B)
    s1 = shortest_distance_point_line(L,line1A,line2A,line2B);
    s2 = shortest_distance_point_line(L,line1B,line2A,line2B);
    s3 = shortest_distance_point_line(L,line2A,line1A,line1B);
    s4 = shortest_distance_point_line(L,line2B,line1A,line1B);
    s = min([s1 s2 s3 s4]);
    