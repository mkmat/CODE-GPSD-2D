function p = get_random_p(L,rs,x)
    overlap=true;
    while overlap==true
        p = (rand(1,2)-0.5)*L; 
        overlap=false; R=fold(L,bsxfun(@minus,x,p)); if min(sqrt(sum(R'.^2)))<rs, overlap=true; end
    end