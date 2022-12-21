function [r,c] = get_pore_quantities_from_edges(L,rs,rp,x,p,id,A,B,C,lenA,lenB,lenC,MaxPoreRadius,triangles_for_triangle) 
    j=find_triangle_for_p(L,x,id,A,B,p); 
    disp(['found triangle no ' num2str(j) ' for p = ' num2str(p)]); 
    triangle_nos = triangles_for_triangle{j}; 
    disp([num2str(length(triangle_nos)) ' relevant triangles']);
    r = 0;
    for jj=1:length(triangle_nos); j = triangle_nos(jj); P = fold(L,p-x(id(j),:));  
        R = []; candidate = 0; cc = []; EPS = (lenA(j)+lenB(j))/1000; 
        PA = A(j,:)-P;
        if lenA(j)-rs>=norm(PA)
            candidate = candidate + 1; 
            R(candidate) = lenA(j)-rs;
            cc{candidate} = x(id(j),:)+A(j,:);
        end
        PB = B(j,:)-P; 
        if lenB(j)-rs>=norm(PB)
            candidate = candidate + 1; 
            R(candidate) = lenB(j)-rs;
            cc{candidate} = x(id(j),:)+B(j,:);
        end
        alpha = dot(P,A(j,:));
        beta  = dot(P,C(j,:));
        gamma = dot(P,P)-rs^2; 
        denom = (2*rs*lenC(j))^2-4*beta^2; 
        a = (2*beta*(2*alpha-gamma)-(2*rs)^2*dot(A(j,:),C(j,:)))/denom;
        b = ((gamma-2*alpha)^2-(2*rs*lenA(j))^2)/denom;
        t = a + sqrt(a^2+b);
        myC = A(j,:)+t*C(j,:); 
        RR = norm(myC)-rs;
        RC = norm(myC-P); 
        if ((t>0)&&(t<1)&&(abs(RR-RC)<EPS)) 
            candidate = candidate + 1; 
            R(candidate) = RR;
            cc{candidate} = x(id(j),:)+myC;
        end
        t = a - sqrt(a^2+b);
        myC = A(j,:)+t*C(j,:); 
        RR = norm(myC)-rs;
        RC = norm(myC-P); 
        if ((t>0)&&(t<1)&&(abs(RR-RC)<EPS)) 
            candidate = candidate + 1; 
            R(candidate) = RR;
            cc{candidate} = x(id(j),:)+myC;
        end
        if R
            largest = find(R==max(R)); 
            if R(largest)+rp>r
                r = R(largest)+rp;
                c = cc{largest}; 
            end   
        end
    end
    if r==0
        r = nan;
        c = nan(1,2);
        disp(['no pore found at p = ' num2str(p)]);
    end