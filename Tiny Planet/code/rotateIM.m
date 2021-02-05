function [a1,angle] = rotateIM(im1,im2)
%% finding corners
im1 = imresize(im2double(imread('img/034.jpg')),0.5);
im2 = imresize(im2double(imread('img/048.jpg')),0.5);
im1_g = rgb2gray(im1);
im2_g = rgb2gray(im2);
im_cha1 = im1_g-im2_g;
im_cha2 = im2_g-im1_g;
%%
blurh = fspecial('gauss',25,50); 
maska = imfilter(im_cha1,blurh,'replicate');
maskb = imfilter(im_cha2,blurh,'replicate');
%% Getting describer
[y1 x1 v1] = easySuppress(im1, 0.05, maska);
[y2 x2 v2] = easySuppress(im2, 0.05, maskb);
%%
[p1]=feat_desc(im1,y1,x1);
[p2]=feat_desc(im2,y2,x2);
%% Feature matching
 [m] = feat_match(p1,p2);
 ind_p1 = find(m~=-1);
 ind_p2 = m(ind_p1);
 %% The Matching points
 ptset1 = [x1,y1];
 im_pt1 = ptset1(ind_p1,:);
 ptset2 = [x2,y2];
 im_pt2 = ptset2(ind_p2,:);
 
%  %% visual im1
% figure;
% imagesc(im1);
% colormap(gray);
% hold on;
% plot(x1,y1,'r.');
% plot(im_pt1(:,1),im_pt1(:,2),'b.');
% hold off;
%  % visual im2
% figure;
% imagesc(im2);
% colormap(gray);
% hold on;
% plot(x2,y2,'r.');
% plot(im_pt2(:,1),im_pt2(:,2),'b.');
% hold off; 
%%
im1_mean = [mean(im_pt1(:,1)),mean(im_pt1(:,2))];

%im1_mean_w = bsxfun(@rdivide, im1_mean_w, im1_mean_w(3,:));
%im1_mean_w = im1_mean_w(1:2,:)';
im2_mean = [mean(im_pt2(:,1)),mean(im_pt2(:,2))];
%% angle
a1 = mod(atan2( det([im2_mean-im1_mean;[0,1];]) , dot((im2_mean-im1_mean),[0,1]) ), 2*pi );
angle = pi/2-abs((a1>pi/2)*pi-a1);  
%%
% cropping = size(im1,2)*sin(angle);
% im_rotated = imrotate(im2,angle,'bicubic');
% im_rotated_crop = im_rotated(cropping+1:size(im_rotated,1),cropping+1:size(im_rotated,2)-cropping,:);
% figure;
% imshow(im_rotated_crop);



 