function xx = replicate_material(L,x)
    xx = []; for k1=-1:1; for k2=-1:1; xx=[xx;x(:,1)+k1*L x(:,2)+k2*L]; end; end
