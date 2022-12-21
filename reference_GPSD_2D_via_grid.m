function [radius,GPSD,GPSDcum,cpusecs,X,Y,MK]=reference_GPSD_2D_via_grid(L,x,ro,rc,rp,grid_resolution,PSDbins)

    show_figures = false;   % activate to see the EDM and MK grids

    tic; 
    N       = length(x(:,1)); 
    dg      = L/grid_resolution;  
    g       = (-L/2+dg/2):dg:(L/2-dg/2); 
    [X,Y]   = meshgrid(g,g);  
    G       = [X(:) Y(:)]; 
    reff    = rc+rp;
    rs      = ro+reff; 

    EDM     = 2*L+0*X;  % distance from effective surface
    for j=1:N
        D = fold(L,bsxfun(@minus,G,x(j,:))); 
        lenD = max(0,sqrt(sum(D'.^2))-rs); 
        EDM(:) = min(EDM(:),lenD(:));
    end

    if show_figures
        figure; pcolor(X,Y,EDM); colorbar; hold on;
        plot(x(:,1),x(:,2),'r.'); shading flat; axis image; pause(eps);
    end

    MK = EDM;
    for j=1:length(EDM(:))
        D = fold(L,bsxfun(@minus,G,G(j,:)));
        lenD = sqrt(sum(D'.^2)); 
        F = find(lenD<=EDM(j)); 
        MK(F) = max(MK(F),EDM(j)); 
    end

    if show_figures
        figure; surf(X,Y,MK); colorbar; shading flat; axis image; pause(eps);
    end

    MaxPoreRadius = max(MK(:));
    disp(['grid-based reference rmax ' num2str(MaxPoreRadius)]);
    disp(['grid-based reference maximum pore radius ' num2str(MaxPoreRadius+rp)])
    disp(['grid-based V(0|reff) = ' num2str(length(find(MK(:)>0))/length(X(:)))]); 
    [GPSD,radius]=hist(MK(find(MK(:)>0)),PSDbins);
    radius = radius + rp; 
    GPSD = GPSD/sum(GPSD*(radius(2)-radius(1))); 
    GPSDcum = cumsum(GPSD); GPSDcum=GPSDcum/GPSDcum(end); 
    cpusecs = toc; 
    disp(['grid-based reference ' num2str(1e9*cpusecs/length(EDM(:))) ' nano-seconds per node']); 
    disp(['grid-based walltime ' num2str(cpusecs) ' seconds']);