function [radius,GPSD,GPSDcum]=return_PSD_for_specified_bins(rp,r,PSDbins)
    maxr = max(r); 
    if length(PSDbins)==1
        [GPSD,radius] = hist(r+rp,linspace(0,maxr+rp,PSDbins));
    else
        [GPSD,radius] = hist(r+rp,PSDbins);
    end

    % normalization of the G-PSD
    GPSD = GPSD/sum(GPSD*(radius(2)-radius(1))); 

    % cumulative G-PSD
    GPSDcum = cumsum(GPSD); GPSDcum=GPSDcum/GPSDcum(end); 	