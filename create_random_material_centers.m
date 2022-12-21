function x = create_random_material_centers(N,L,ro)
    volumefraction = N*pi*ro^2/L^2; 
    disp(['creating material with ' num2str(N) ' particles of radius ' num2str(ro) ' at volume fraction ' num2str(volumefraction)]); 
    n=0; 
    while n<N
        n=n+1; 
        x(n,:) = (rand(1,2)-0.5)*L;
        while overlapping(n,L,x,ro)==true
            x(n,:) = (rand(1,2)-0.5)*L;
        end
    end
    disp('done');