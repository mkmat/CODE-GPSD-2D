function [radius,TsPSD,TsPSDcum,cpusecs]=get_Ts_PSD_P_r(L,x,PSDbins,shots,MaxPoreRadius)
    if length(PSDbins)==1
        radius = linspace(0,MaxPoreRadius,PSDbins);
    else
        radius = PSDbins;
    end
    tic; 
    TsPSDcum = 0*radius; 
    for s=1:shots
        R = (rand(1,2)-0.5)*L;
        D = fold(L,bsxfun(@minus,x,R));
        d = sqrt(sum(D'.^2)); 
        use = find(radius<=min(d)); 
        TsPSDcum(use) = TsPSDcum(use) + 1; 
    end
    TsPSDcum = 1-TsPSDcum/TsPSDcum(1);
    TsPSD = gradient(TsPSDcum)./gradient(radius);
    cpusecs = toc; 
