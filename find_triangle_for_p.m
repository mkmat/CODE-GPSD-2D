function triangle_no = find_triangle_for_p(L,x,id,A,B,p)
    D = fold(L,bsxfun(@minus,x,p)); % may be replaced by neighbor list here (no neighborlist required for the PSD)
    d = sqrt(sum(D'.^2));
    i = find(d==min(d)); i=i(1);    % nearest particle id
    disp(['nearest particle at x = (' num2str(x(i,1)) ',' num2str(x(i,2)) ')'])
    P = fold(L,p-x(i,:));           % relative P
    tids = find(id==i);             % triangles belonging to particle id 
    triangle_no = nan; 
    for j=1:length(tids); tid=tids(j);
        detvv1  = P(1)*A(tid,2)-P(2)*A(tid,1);
        detvv2  = P(1)*B(tid,2)-P(2)*B(tid,1);
        detv1v2 = A(tid,1)*B(tid,2)-A(tid,2)*B(tid,1); 
        a = detvv2/detv1v2; 
        b = -detvv1/detv1v2; 
        if ((a>=0)&(b>=0)&(a+b<=1))
            triangle_no = tid; 
        end
    end