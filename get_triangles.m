function [triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,MaxPoreRadius] = get_triangles(L,rs,rp,x,v,vc)
    dim         = 2; 
    Faces       = length(vc); 
    triangles   = 0; 
    void_res    = 100; 
    t1 = rand(3*void_res,1); t2 = rand(3*void_res,1); remove = find(t1+t2>1); 
    t1(remove)=[]; t2(remove)=[]; t1=t1(1:void_res); t2=t2(1:void_res); 
    for j=1:Faces
        for k=1:length(vc{j})
            triangles = triangles + 1; 
        end
    end
    A           = nan(triangles,dim); B=A; 
    triangles   = 0; 
    for j=1:Faces
        for k=1:length(vc{j})
            k1              = 1+mod(k,length(vc{j}));
            triangles       = triangles + 1; 
            A(triangles,:)  = fold(L,v(vc{j}(k),:) -x(j,:));
            B(triangles,:)  = fold(L,v(vc{j}(k1),:)-x(j,:));
            Tpoints         = t1*A(triangles,:)+t2*B(triangles,:);
            lenTpoints      = sqrt(sum(Tpoints'.^2));
            VoidArea(triangles) = length(find(lenTpoints>=rs))/length(t1)*abs(A(triangles,1)*B(triangles,2)-A(triangles,2)*B(triangles,1))/2;
            id(triangles)   = j;
        end
    end
    C    = B-A; 
    lenA = sqrt(sum(A'.^2)); 
    lenB = sqrt(sum(B'.^2)); 
    lenC = sqrt(sum(C'.^2)); 
    MaxPoreRadius = max(max(lenA),max(lenB))-rs+rp; 
    disp(['information for ' num2str(triangles) ' triangles recorded']); 