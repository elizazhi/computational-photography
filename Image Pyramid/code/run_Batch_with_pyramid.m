% 15-463: Assignment 1, run_Batch_with_pyramid

% getting the image files
files_tif = dir('*.tif');
files_jpg = dir('*.jpg');
files = cell(2,1);
files{1,1} = files_tif;
files{2,1} = files_jpg;

% making folders for storage
if ~exist('jpg', 'dir')
  mkdir('jpg');
end
if ~exist('tif', 'dir')
  mkdir('tif');
end
if ~exist('tif/big', 'dir')
  mkdir('tif/big');
end
if ~exist('tif/small', 'dir')
  mkdir('tif/small');
end

% making a file to store the offsets
offsets = cell(2,1);

for format = 1: size(files,1)
    offsets{format,1} = cell(size(files{format,1},1), 5);
for file = 1:size(files{format,1},1)
% name of the input file
imname = files{format,1}(file).name;
% store the name in the offset matrix
imname1 = {imname};
offsets{format,1}(file,1) = imname1;

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

%Generating data and storing it in a cell array
pyramid = cell(10,3);
pyramid{1,1} = B;
pyramid{1,2} = R;
pyramid{1,3} = G;
ii = 1;
for i = 1:9
  if min(size(pyramid{i,1}))> 500
    pyramid{i+1,1} = impyramid(pyramid{i,1}, 'reduce');
    pyramid{i+1,2} = impyramid(pyramid{i,2}, 'reduce');
    pyramid{i+1,3} = impyramid(pyramid{i,3}, 'reduce');
    ii = ii+1;
  end
end
pyramid = pyramid(1:ii, :);

% Align the images
% G and B
range1 = 20;
range2 = 4;
    
[Rprime, rr, cr] = exhaustiveAlign(pyramid{ii,2}, pyramid{ii,1}, range1, 0.2, 0.8);
[Gprime, rg, cg] = exhaustiveAlign(pyramid{ii,3}, pyramid{ii,1}, range1, 0.2, 0.8);
if size(pyramid,1)==1
   aR = Rprime;
   aG = Gprime;
   rr = rr-range1-1;
   cr = cr-range1-1;
   rg = rg-range1-1;
   cg = cg-range1-1;
else
   rr = 2 * (rr-range1-1);
   cr = 2 * (cr-range1-1);
   rg = 2 * (rg-range1-1);
   cg = 2 * (cg-range1-1);
   pyramid{ii-1,2} = circshift(circshift(pyramid{ii-1,2}, rr, 1), cr,2);
   pyramid{ii-1,3} = circshift(circshift(pyramid{ii-1,3}, rg, 1), cg,2);
   [Rprime, rr0, cr0] = exhaustiveAlign(pyramid{ii-1,2}, pyramid{ii-1,1}, range2, 0.2, 0.8);
   [Gprime, rg0, cg0] = exhaustiveAlign(pyramid{ii-1,3}, pyramid{ii-1,1}, range2, 0.2, 0.8);
   if ii == 2
       aR = Rprime;
       aG = Gprime;
       rr = rr + (rr0-range2-1);
       cr = cr + (cr0-range2-1);
       rg = rg + (rg0-range2-1);
       cg = cg + (cg0-range2-1);
   else
       for j = 3:ii
           rr = 2 * rr + 2 * (rr0-range2-1);
           cr = 2 * cr + 2 * (cr0-range2-1);
           rg = 2 * rg + 2 * (rg0-range2-1);
           cg = 2 * cg + 2 * (cg0-range2-1);
          pyramid{ii-j+1,2} = circshift(circshift(pyramid{ii-j+1,2}, rr, 1), cr,2);
          pyramid{ii-j+1,3} = circshift(circshift(pyramid{ii-j+1,3}, rg, 1), cg,2);
          [Rprime, rr0, cr0] = exhaustiveAlign(pyramid{ii-j+1,2}, pyramid{ii-j+1,1}, range2, 0.2, 0.8);
          [Gprime, rg0, cg0] = exhaustiveAlign(pyramid{ii-j+1,3}, pyramid{ii-j+1,1}, range2, 0.2, 0.8); 
       end
       aR = Rprime;
       aG = Gprime;
       rr = rr + (rr0-range2-1);
       cr = cr + (cr0-range2-1);
       rg = rg + (rg0-range2-1);
       cg = cg + (cg0-range2-1);
   end       
end

% open figure
%% figure(1);

% create a color image (3D array)
colorim = cat(3,aR,aG,B);
sizecol = size(colorim(:,:,1));

% store the offsets
offsets{format,1}(file,2) = {rr};
offsets{format,1}(file,3) = {cr};
offsets{format,1}(file,4) = {rg};
offsets{format,1}(file,5) = {cg};

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
%imshow(colorim);

% save result image
if isempty(findstr(imname, '.tif'))
    imwrite(colorim,['jpg/result-' imname]);
else
    imwrite(colorim,['tif/big/result-' imname]);
    imname=strrep(imname,'.tif','.jpg');
    imwrite(colorim,['tif/small/result-' imname]);
end
end
end
save('offsets.mat');