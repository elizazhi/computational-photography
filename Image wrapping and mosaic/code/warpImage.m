function im_warped = warpImage(im,H)
%  im = imresize(im2double(imread('my pics/001.JPG')),0.5);
%  load('F1.mat');
%  load('M1.mat');
%  im1_pts = movingPoints;
%  im2_pts = fixedPoints;
  
%  H = computeH(im1_pts,im2_pts);
 %% Corners
 upper_left = H*[1;1;1];
 upper_right = H*[size(im,2);1;1];
 down_left = H*[1; size(im,1);1];
 down_right = H*[size(im,2);size(im,1);1];
%  %% Built-in
%  lizcorner = [upper_left(1:2)'/upper_left(3); ...
%      upper_right(1:2)'/upper_right(3); ...
%      down_left(1:2)'/down_left(3); ...
%      down_right(1:2)'/down_right(3)];
%  tform = fitgeotrans(im1_pts, im2_pts, 'projective');
%  [h, w, c] = size(im);
%  corners = [1, 1; w, 1; 1, h; w, h];
%  Hcorners = transformPointsForward(tform, corners);
 
 %%
 %new im size
 rows = max(down_left(2)/down_left(3),down_right(2)/down_right(3))-min(upper_left(2)/upper_left(3),upper_right(2)/upper_right(3));
 cols = max(down_right(1)/down_right(3),upper_right(1)/upper_right(3)) - min(down_left(1)/down_left(3),upper_left(1)/upper_left(3));
 % moving offsets
 h_offset = ceil(-min(down_left(1)/down_left(3),upper_left(1)/upper_left(3)));
 v_offset = ceil(-min(upper_left(2)/upper_left(3),upper_right(2)/upper_right(3)));
 
 im_warped = zeros(ceil(rows), ceil(cols),3);
%  %%
% for i = 1:size(im_warped,1)
%     for j = 1:size(im_warped,2)
%         B=[j-h_offset-1; i-v_offset-1;1];
%         im_cor = H\B;
%         if im_cor(1)/im_cor(3)<1 || im_cor(2)/im_cor(3)<1 || im_cor(1)/im_cor(3)>size(im,2) || im_cor(2)/im_cor(3)>size(im,1)
%             im_warped(i,j,:) = [0,0,0];
%         else
%         im_warped(i,j,:) = im(round(im_cor(2)/im_cor(3)),round(im_cor(1)/im_cor(3)),:);
%         %im_warped(round(im_cor(2) + v_offset)+1,round(im_cor(1) + h_offset)+1,:) = im(i,j,:);
%         end
%     end
% end
%%
V = [1:ceil(rows)*ceil(cols)];
[I,J] = ind2sub([ceil(rows),ceil(cols)],V);
b = [J-h_offset-1; I-v_offset-1; ones(1,ceil(rows)*ceil(cols))];
im_cor = H\b;
im_cor = bsxfun(@rdivide,im_cor,im_cor(end,:));
good_index = im_cor(1,:)>=1 & im_cor(1,:)<=size(im,2) & im_cor(2,:)>=1 & im_cor(2,:)<=size(im,1);
%%
V_good = sub2ind([ceil(rows),ceil(cols)], I(good_index), J(good_index));
for c = 1:3
im1 = zeros(ceil(rows),ceil(cols));
im1(V_good) = interp2(im(:,:,c), im_cor(1,good_index),im_cor(2,good_index));
im_warped(:,:,c) = im1;
end