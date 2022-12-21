function [radius,GPSD,GPSDcum]=show_PSD(rc,rp,MaxPoreRadius,r,PSDbins)
    if length(PSDbins)==1
        [GPSD,radius] = hist(r+rp,PSDbins);
    else
        [GPSD,radius] = hist(r+rp,linspace(0,MaxPoreRadius,PSDbins));
    end

    % normalization of the G-PSD
    GPSD = GPSD/sum(GPSD*(radius(2)-radius(1))); 

    % cumulative G-PSD
    GPSDcum = cumsum(GPSD); GPSDcum=GPSDcum/GPSDcum(end); 	

    
    H=figure; set(H,'position',[100 100 800 300]); 

    subplot(1,2,1); 
    semilogy(radius,GPSD,'k.-'); xlabel('$r$','interpreter','latex','fontsize',15); ylabel(['$P(r;' num2str(rp) '|' num2str(rc) ')$'],'interpreter','latex','fontsize',15);
    hold on; plot([MaxPoreRadius MaxPoreRadius],[0 max(GPSD)],'k--')

    subplot(1,2,2); 
    plot(radius,GPSDcum,'k.-'); xlabel('$r$','interpreter','latex','fontsize',15); ylabel(['$P_{\rm cum}(r;' num2str(rp) '|' num2str(rc) ')$'],'interpreter','latex','fontsize',15);
    hold on; plot([MaxPoreRadius MaxPoreRadius],[0 1],'k--');
    
    dlmwrite('_GPSD.txt',[radius' GPSD' GPSDcum']); disp('created _GPSD.txt');