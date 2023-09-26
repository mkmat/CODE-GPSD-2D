function [Ps,triangle_nos] = find_edges_for_p(L,x,id,A,B,p,MaxPoreRadius,rs)
% MAYBE REPLACES BY find_triangle_for_p and find_edges_for_triangle
    D   = fold(L,bsxfun(@minus,x,p)); % may be replaced by neighbor list here
    d   = sqrt(sum(D'.^2));
    is  = find(d<=2*MaxPoreRadius+rs);
    disp([num2str(length(is)) ' particles found in neighborhood']);
    if length(is)>0
        triangle_nos = []; 
        for ii=1:length(is); i=is(ii);  
            triangle_nos = [triangle_nos find(id==i)]; 
        end
        triangle_nos = unique(triangle_nos);
        Ps = fold(L,bsxfun(@minus,x(id(triangle_nos),:),p));
    else
        triangle_nos = []; 
        Ps = nan; 
    end
