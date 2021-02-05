function [y,x,v] = easySuppress(im, r,mask)
%%
[Y,X,V] = harris(im);
Ind = sub2ind([size(mask,1),size(mask,2)],Y,X);
Mask = [V,mask(Ind)]';
v = prod(Mask)';
cs = [Y,X,v];
[M,I]=sort(cs(:,3));
cs=cs(I,:); 
%%
y = cs((1-r)*length(Y):end,1);
x = cs((1-r)*length(X):end,2);
v = cs((1-r)*length(V):end,3);

% figure;
% imagesc(im);
% colormap(gray);
% hold on;
% plot(x,y,'r.');
% hold off;