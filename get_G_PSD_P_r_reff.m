function [r,cpusecs] = get_G_PSD_P_r_reff(N,L,x,rs,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,triangles_for_triangle,shots)
    tic; 
    voidareas = sum(VoidArea); disp(['void area ' num2str(voidareas) ' distributed over ' num2str(triangles) ' triangles']);
    totalvoidarea = sum(VoidArea); disp(['void area fraction ' num2str(totalvoidarea/L^2) ' (expected for non-overlapping ' num2str((L^2-N*pi*rs^2)/L^2) ')']); 
    shots_per_area = shots/totalvoidarea; 
    shots_performed = 0; 
    r = zeros(shots,1); 
    for jp=1:triangles
        shots_into_triangle = round(shots_per_area*VoidArea(jp));
        EPS = (lenA(jp)+lenB(jp))/1000; 
        triangle_nos = triangles_for_triangle{jp}; 
        for s=1:shots_into_triangle
            t = rand(1,2); P = t(1)*A(jp,:)+t(2)*B(jp,:); 
            while ((t(1)>1-t(2))||(norm(P)<rs)), t = rand(1,2); P = t(1)*A(jp,:)+t(2)*B(jp,:); end  % shoot into triangle, at > rs neighborhood of material particle
            % plot(x(id(j),1)+P(1),x(id(j),2)+P(2),'r.'); pause; % show random shot positions
            R = []; candidate = 0; p = x(id(jp),:)+P; 
            for jj=1:length(triangle_nos); j=triangle_nos(jj); P = fold(L,p-x(id(j),:)); 
                PA = A(j,:)-P;
                if lenA(j)-rs>=norm(PA)
                    candidate = candidate + 1; 
                    R(candidate) = lenA(j)-rs;
                end
                PB = B(j,:)-P; 
                if lenB(j)-rs>=norm(PB)
                    candidate = candidate + 1; 
                    R(candidate) = lenB(j)-rs;
                end
                alpha = dot(P,A(j,:));
                beta  = dot(P,C(j,:));
                gamma = dot(P,P)-rs^2; 
                denom = (2*rs*lenC(j))^2-4*beta^2; 
                a = (2*beta*(2*alpha-gamma)-(2*rs)^2*dot(A(j,:),C(j,:)))/denom;
                b = ((gamma-2*alpha)^2-(2*rs*lenA(j))^2)/denom;
                t = a + sqrt(a^2+b);
                RR = norm(A(j,:)+t*C(j,:))-rs;
                RC = norm(A(j,:)+t*C(j,:)-P); 
                if ((t>0)&&(t<1)&&(abs(RR-RC)<EPS))
                    candidate = candidate + 1; 
                    R(candidate) = RR;
                end
                t = a - sqrt(a^2+b);
                RR = norm(A(j,:)+t*C(j,:))-rs;
                RC = norm(A(j,:)+t*C(j,:)-P); 
                if ((t>0)&&(t<1)&&(abs(RR-RC)<EPS))
                    candidate = candidate + 1; 
                    R(candidate) = RR;
                end
            end
            if R
                shots_performed = shots_performed + 1; 
                r(shots_performed) = max(R);
            end
        end
    end
    disp([num2str(shots_performed/shots*100) ' % of ' num2str(shots) ' shots performed']); 
    r((shots_performed+1):end)=[]; 
    cpusecs = toc; 
    disp(['walltime ' num2str(cpusecs) ' seconds, i.e., ' num2str(toc/shots_performed*1e9) ' nano-seconds per point p'])