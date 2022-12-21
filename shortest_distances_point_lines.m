function s = shortest_distances_point_lines(L,point,lineAs,lineBs)
    rel     = fold(L,bsxfun(@minus,lineAs,point)); 
    lineCs  = lineBs-lineAs;
    t       = max(0,min(1,(lineCs(:,1).*rel(:,1)+lineCs(:,2).*rel(:,2))./sum(lineCs'.^2)'));
    AtC     = [lineAs(:,1)+t.*lineCs(:,1) lineAs(:,2)+t.*lineCs(:,2)];
    rel     = fold(L,bsxfun(@minus,AtC,point)); 
    s       = sqrt(sum(rel'.^2)); 