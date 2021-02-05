function [y x rmax] = anms(im, max_pts);
[Y,X,V] = harris(im);
cimg = [X,Y,V];
[M,I]=sort(cimg(:,3),'descend');
cimg=cimg(I,:); 

%%
R = zeros(size(cimg,1),1);
robust = zeros(size(cimg,1),1);
for i = 2:size(cimg,1)
    radi = zeros(i-1,2);
    for j = 1:i-1
        radi(j,1) = (cimg(i,1)-cimg(i-j,1))^2+(cimg(i,2)-cimg(i-j,2))^2;
        radi(j,2) = cimg(j,3)*0.9;
    end
    radi_valid = radi(radi(:,2)>cimg(i,3),1);
    if isempty(radi_valid)
        R(i) = 0;
    else
        R(i) = min(radi_valid);
    end
end
R(1) = Inf;
%%

cimg = [cimg,R];
[MM,II]=sort(cimg(:,4),'descend');
cimg=cimg(II,:); 
%%
y = cimg(1:max_pts,2);
x = cimg(1:max_pts,1);
rmax = sqrt(cimg(max_pts,4));
%%
figure;
imagesc(im);
colormap(gray);
hold on;
plot(cimg(1:100,1),cimg(1:100,2),'r.');
hold off;