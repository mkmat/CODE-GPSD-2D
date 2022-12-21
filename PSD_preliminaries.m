function [reff,rs,xx,v,vc,triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,MaxPoreRadius,triangles_for_triangle]=PSD_preliminaries(N,L,ro,rc,rp,x)
    reff    = rc+rp; 
    rs      = ro+reff; 
    xx      = replicate_material(L,x); 
    [v,vc]  = voronoin(xx);
    [v,vc]  = periodic_reduction(N,v,vc);
    [triangles,id,A,B,C,lenA,lenB,lenC,VoidArea,MaxPoreRadius] = get_triangles(L,rs,rp,x,v,vc);   
    disp(['maximum pore radius ' num2str(MaxPoreRadius) ' at ro = ' num2str(ro) ' and rc = ' num2str(rc) ' and rp = ' num2str(rp)]); 

% % %     % edges for all triangles for PSD lateron (this is the slow part)
% % %     disp(['getting potential edges (slow version)'])
% % %     triangles_for_triangle = cell(triangles,1); 
% % %     for attempts = 10:10
% % %         counter  = 0;
% % %         for triangle_no = 1:triangles
% % %             triangle_no
% % %             triangles_for_triangle{triangle_no} = find_edges_for_triangle_brute_force(L,rs,x,id,A,B,lenA,lenB,triangle_no,triangles_for_triangle,attempts);
% % %             counter = counter + length(triangles_for_triangle{triangle_no}); 
% % %         end
% % %         disp(['counter ' num2str(counter)]); 
% % %     end
% % %     disp([num2str(counter/triangles) ' potential edges per triangle']); 

    % edges for all triangles for PSD lateron (this is the speed version)
    disp(['getting potential edges (speed version)'])
    counter  = 0;
    absA = x(id(:),:) + A;
    absB = x(id(:),:) + B; 
    for triangle_no = 1:triangles
        triangles_for_triangle{triangle_no} = find_edges_for_triangle_speedversion(L,rs,x,id,lenA,lenB,absA,absB,triangle_no);
        counter = counter + length(triangles_for_triangle{triangle_no});
    end
    disp([num2str(counter/triangles) ' potential edges per triangle']); 