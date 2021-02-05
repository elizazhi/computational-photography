files = dir('*.tif');

% 15-463: Assignment 1, pyramid
for i = 1:size(files,1)
    % name of the input file
imname = files(i).name;

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

% creating 3 levels of pyramids for every channel
Bp1 = impyramid(B, 'reduce');
Bp2 = impyramid(Bp1, 'reduce');
Bp3 = impyramid(Bp2, 'reduce');
Rp1 = impyramid(R, 'reduce');
Rp2 = impyramid(Rp1, 'reduce');
Rp3 = impyramid(Rp2, 'reduce');
Gp1 = impyramid(G, 'reduce');
Gp2 = impyramid(Gp1, 'reduce');
Gp3 = impyramid(Gp2, 'reduce');

% Getting the size of each level of pyramid

% Align the images
% G and B
range3 = 20;
[Gp3prime, r03, c03] = exhaustiveAlign(Gp3, Bp3, range3, 0.2, 0.8);
Gp2prime = circshift(circshift(Gp2, 2*(r03-range3-1), 1), 2*(c03-range3-1),2);

range2 = 2;
[Gp2prime1, r02, c02] = exhaustiveAlign(Gp2prime, Bp2, range2, 0.2, 0.8);
 
Gp1prime = circshift(circshift(Gp1, 4*(r03-range3-1)+2*(r02-range2-1), 1), 4*(c03-range3-1)+2*(c02-range2-1),2);

range1 = 2;
[Gp1prime1, r01, c01] = exhaustiveAlign(Gp1prime, Bp1, range1, 0.2, 0.8);
Gprime = circshift(circshift(G, 8*(r03-range3-1)+4*(r02-range2-1)+2*(r01-range1-1), 1), 8*(c03-range3-1)+4*(c02-range2-1)+2*(c01-range1-1),2);
 
range = 2;
[Gprime1, r0, c0] = exhaustiveAlign(Gprime, B, range, 0.2, 0.8);
% the aligned green channel
aG = circshift(circshift(Gprime1, 2*(r0-range-1), 1), 2*(c0-range-1),2);

% Aligning B and R channel
[Rp3prime, r03, c03] = exhaustiveAlign(Rp3, Bp3, range3, 0.2, 0.8);
Rp2prime = circshift(circshift(Rp2, 2*(r03-range3-1), 1), 2*(c03-range3-1),2);

[Rp2prime1, r02, c02] = exhaustiveAlign(Rp2prime, Bp2, range2, 0.2, 0.8);
 
Rp1prime = circshift(circshift(Rp1, 4*(r03-range3-1)+2*(r02-range2-1), 1), 4*(c03-range3-1)+2*(c02-range2-1),2);
 
[Rp1prime1, r01, c01] = exhaustiveAlign(Rp1prime, Bp1, range1, 0.2, 0.8);
Rprime = circshift(circshift(R, 8*(r03-range3-1)+4*(r02-range2-1)+2*(r01-range1-1), 1), 8*(c03-range3-1)+4*(c02-range2-1)+2*(c01-range1-1),2);
 
[Rprime1, r0, c0] = exhaustiveAlign(Rprime, B, range, 0.2, 0.8);
% the aligned green channel
aR = circshift(circshift(Rprime1, 2*(r0-range-1), 1), 2*(c0-range-1),2);

% open figure
%% figure(1);

% create a color image (3D array)
colorim = cat(3,aR,aG,B);
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

% save result image
imwrite(colorim,['result-' imname]);
% save result as jpg
imnameJPG=strrep(imname,'.tif','.jpg');
imwrite(colorim,['result-' imnameJPG]);
end
