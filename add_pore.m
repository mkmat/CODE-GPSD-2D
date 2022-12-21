function add_pore(L,p,c,r,rp)
    phis = linspace(0,2*pi,100);
    plot(p(1),p(2),'ko','markerfacecolor',[0.8 0 0]); hold on;
    plot(p(1)+rp*cos(phis),p(2)+rp*sin(phis),'k-','color',[0.8 0 0]);
    for k1=-1:1; for k2=-1:1; plot(c(1)+k1*L+r*cos(phis),c(2)+k2*L+r*sin(phis),'g-'); end; end
    plot(c(1),c(2),'go','markerfacecolor',[0 0 0.8]); 
    axis([-1 1 -1 1]*L/2);