function add_material(xx,L,ro,rc)
    phis=linspace(0,2*pi,100); 
    for j=1:length(xx(:,1)); plot(xx(j,1)+ro*cos(phis),     xx(j,2)+ro*sin(phis),'k-');       hold on; end  
    for j=1:length(xx(:,1)); plot(xx(j,1)+(ro+rc)*cos(phis),xx(j,2)+(ro+rc)*sin(phis),'k--'); hold on; end
    axis equal; axis([-1 1 -1 1]*L/2);
