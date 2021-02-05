function [y,x,v] = nonMaximaSupress(im, r)
[Y,X,V] = harris(im);
cs = [Y,X,V];
[M,I]=sort(cs(:,3));
cs=cs(I,:); 

y = cs((1-r)*length(Y):end,1);
x = cs((1-r)*length(X):end,2);
v = cs((1-r)*length(V):end,3);

figure;
imagesc(im);
colormap(gray);
hold on;
plot(x,y,'r.');
hold off;