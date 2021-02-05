spoints = im1_pts(1:4,:);
dpoints = im2_pts(1:4,:);
    %%
    %/////////////homography matrix///////////////////
    n = L; 
    a = zeros(n*2,8); 
    b = zeros(n*2,1); 
    %%
    j=1;
    for i=1:n
        a(j,:)=[spoints(i,1) spoints(i,2) 1 0 0 0 -spoints(i,1)*dpoints(i,1) -dpoints(i,1)*spoints(i,2)];
        b(j,1)=dpoints(i,1);
        j=j+1;
        a(j,:)=[0 0 0 spoints(i,1) spoints(i,2) 1 -dpoints(i,2)*spoints(i,1) -dpoints(i,2)*spoints(i,2)];
        b(j,1)=dpoints(i,2);
        j=j+1;
    end

    x = (a\b);
    H = [x(1,1) x(2,1) x(3,1);
        x(4,1) x(5,1) x(6,1);
        x(7,1) x(8,1) 1];