function overlap = overlapping(N,L,x,ro)
    for j=1:N; R=fold(L,bsxfun(@minus,x(1:(j-1),:),x(j,:))); if min(sqrt(sum(R'.^2)))<2*ro, overlap=true; return; end; end
    overlap=false;