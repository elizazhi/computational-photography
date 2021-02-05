%% finding corners
im1 = imresize(im2double(imread('../my pics/301.JPG')),0.5);
im2 = imresize(im2double(imread('../my pics/302.JPG')),0.5);
[y1 x1 rmax1] = anms(im1, 250);
[y2 x2 rmax2] = anms(im2, 250);
%% Getting describer
im1_g = rgb2gray(im1);
im2_g = rgb2gray(im2);

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
 
 %% visual im1
figure;
imagesc(im1);
colormap(gray);
hold on;
plot(x1,y1,'r.');
plot(im_pt1(:,1),im_pt1(:,2),'b.');
hold off;
 %% visual im2
figure;
imagesc(im2);
colormap(gray);
hold on;
plot(x2,y2,'r.');
plot(im_pt2(:,1),im_pt2(:,2),'b.');
hold off; 
 %% Ransac
 addpath('../');
 [H,inlier_ind] = ransac_est_homography(im_pt1(:,2), im_pt1(:,1), im_pt2(:,2), im_pt2(:,1), 10);

%% visual Ransac
% im1
figure;
imagesc(im1);
colormap(gray);
hold on;
plot(x1,y1,'r.');
plot(im_pt1(:,1),im_pt1(:,2),'b.');
plot(im_pt1(inlier_ind,1),im_pt1(inlier_ind,2),'g.');
hold off; 
%% im2
figure;
imagesc(im2);
colormap(gray);
hold on;
plot(x2,y2,'r.');
plot(im_pt2(:,1),im_pt2(:,2),'b.');
plot(im_pt2(inlier_ind,1),im_pt2(inlier_ind,2),'g.');
hold off; 
 
%%
im1_mean = [mean(im_pt1(inlier_ind,1));mean(im_pt1(inlier_ind,2));1];
im1_mean_w = H*im1_mean;
im1_mean_w = bsxfun(@rdivide, im1_mean_w, im1_mean_w(3,:));
im1_mean_w = im1_mean_w(1:2,:)';
im2_mean = [mean(im_pt2(inlier_ind,1)),mean(im_pt2(inlier_ind,2))];
%%
im_warped = warpImage(im1,H);
imshow(im_warped);
%%
imwrite(im_warped,'FN-301-Ransac.JPG');


 