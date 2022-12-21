function [radius,V,GPSD,GPSDcum]=benchmark_analytic(rc,rp,PSDbins)
    ro      = 1; 
    reff    = rc+rp; 
    rs      = ro+reff;
    L       = 2; 
    rmax    = sqrt(2)*ro - rs;
    r       = linspace(0,rmax,PSDbins); 
    x       = ro - sqrt((rs+r).^2-ro^2);
    beta    = atan(1-x/ro);
    alpha   = pi/2-beta; 
    gamm    = alpha-pi/4; 
    V       = 4*(ro*x-rs^2*gamm+r.^2.*alpha).*heaviside(rmax-r);
    GPSDcum = 1-(r.^2.*alpha+ro*x-rs^2*gamm)/(ro*x(1)-rs^2*gamm(1)).*heaviside(rmax-r);
    GPSD    = gradient(GPSDcum)./gradient(r); 
    radius  = r+rp; 
    disp(['analytic maxumum pore radius ' num2str(rmax+rp)]); 


    