% 15-463: Assignment 1, starter Matlab code

% name of the input file
imname = '01657v.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

sizeI = size(R);
% Align the images

range = 20;
[Gprime, r01, c01] = exhaustiveAlign(G, B, range, 0.2, 0.8);
[Rprime, r02, c02] = exhaustiveAlign(R, B, range, 0.2, 0.8);

% taking the overlap of 3 channels (getting rid of edges)
top = - min([0,r01-range-1,r02-range-1])+1;
bottom = sizeI(1)-max([0, r01-range-1,r02-range-1])-1;
left = -min([0, c01-range-1, c02-range-1])+1;
right = sizeI(2)-max([0, c01-range-1, c02-range-1])-1;

% open figure
%% figure(1);

% create a color image (3D array)
colorim = cat(3,Rprime(top:bottom,left:right),Gprime(top:bottom,left:right),B(top:bottom,left:right));
sizecol = size(colorim(:,:,1));

% refining borders
edge1 = floor(0.1*sizecol(1));
edge2 = floor(0.1*sizecol(2));
edges1 = zeros(edge1,6);
% 1--top
for e = 1:edge1
    edges1(e,1) = mean(colorim(e,:,1));
    edges1(e,2) = mean(colorim(e,:,2));
    edges1(e,3) = mean(colorim(e,:,3));
    edges1(e,4) = abs(edges1(e,1)-mean(edges1(1:e, 1)));
    edges1(e,5) = abs(edges1(e,2)-mean(edges1(1:e, 2)));
    edges1(e,6) = abs(edges1(e,3)-mean(edges1(1:e, 3)));
end
eR_top = find(edges1(:,4)==max(edges1(:,4)))-1;
eG_top = find(edges1(:,5)==max(edges1(:,5)))-1;
eB_top = find(edges1(:,6)==max(edges1(:,6)))-1;
e_top = max([eR_top,eG_top,eB_top]);

% 2--bottom
for e = 1:edge1
    edges1(e,1) = mean(colorim(sizecol(1)-e+1,:,1));
    edges1(e,2) = mean(colorim(sizecol(1)-e+1,:,2));
    edges1(e,3) = mean(colorim(sizecol(1)-e+1,:,3));
    edges1(e,4) = abs(edges1(e,1)-mean(edges1(1:e, 1)));
    edges1(e,5) = abs(edges1(e,2)-mean(edges1(1:e, 2)));
    edges1(e,6) = abs(edges1(e,3)-mean(edges1(1:e, 3)));
end
eR_bottom = find(edges1(:,4)==max(edges1(:,4)))-1;
eG_bottom = find(edges1(:,5)==max(edges1(:,5)))-1;
eB_bottom = find(edges1(:,6)==max(edges1(:,6)))-1;
e_bottom = sizecol(1)-max([eR_bottom,eG_bottom,eB_bottom])+1;

% 3--left
edges2 = zeros(edge2,6);
for e = 1:edge2
    edges2(e,1) = mean(colorim(:,e,1));
    edges2(e,2) = mean(colorim(:,e,2));
    edges2(e,3) = mean(colorim(:,e,3));
    edges2(e,4) = abs(edges2(e,1)-mean(edges2(1:e, 1)));
    edges2(e,5) = abs(edges2(e,2)-mean(edges2(1:e, 2)));
    edges2(e,6) = abs(edges2(e,3)-mean(edges2(1:e, 3)));
end
eR_left = find(edges2(:,4)==max(edges2(:,4)))-1;
eG_left = find(edges2(:,5)==max(edges2(:,5)))-1;
eB_left = find(edges2(:,6)==max(edges2(:,6)))-1;
e_left = max([eR_left,eG_left,eB_left]);

% 4--right
for e = 1:edge2
    edges2(e,1) = mean(colorim(:,sizecol(2)-e+1,1));
    edges2(e,2) = mean(colorim(:,sizecol(2)-e+1,2));
    edges2(e,3) = mean(colorim(:,sizecol(2)-e+1,3));
    edges2(e,4) = abs(edges2(e,1)-mean(edges2(1:e, 1)));
    edges2(e,5) = abs(edges2(e,2)-mean(edges2(1:e, 2)));
    edges2(e,6) = abs(edges2(e,3)-mean(edges2(1:e, 3)));
end
eR_right = find(edges2(:,4)==max(edges2(:,4)))-1;
eG_right = find(edges2(:,5)==max(edges2(:,5)))-1;
eB_right = find(edges2(:,6)==max(edges2(:,6)))-1;
e_right = sizecol(2)-max([eR_right,eG_right,eB_right])+1;

% show the resulting image
colorim = colorim(e_top:e_bottom,e_left:e_right,:);
imshow(colorim);

% save result image
imwrite(colorim,['result-' imname]);