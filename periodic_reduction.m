function [v,vc] = periodic_reduction(N,v,vc)
    Faces = length(vc);
    disp([num2str(Faces) ' faces and ' num2str(length(v)) ' vertices prior reduction (periodic box)']);   
    required_vertices = []; 
    for j=(4*N+1):(5*N) % central cell
        required_vertices = [required_vertices vc{j}];
    end
    required_vertices = unique(required_vertices);
    mapto = zeros(1,length(v(:,1))); 
    mapto(required_vertices) = 1:length(required_vertices);  % v(mapto(j)) = v(j)
    for j=1:length(v(:,1))
       if mapto(j)~=0, v(mapto(j),:) = v(j,:); end
    end
    reduced_vc = cell(N,1); 
    for j=1:N 
        reduced_vc{j} = mapto(vc{4*N+j}); 
    end
    vc = reduced_vc;
    Faces = length(vc);
    v((length(required_vertices)+1):end,:) = []; 
    disp([num2str(Faces) ' faces and ' num2str(length(v)) ' vertices after reduction (periodic box)']);   