%% read image to be warped 
im = im2double(imread('ExCap/IMG_0161_flock.jpg'));
 
% defining point pairs
 moving = imread('ExCap/IMG_0161_flock.jpg');
 fixed = imread('ExCap/IMG_back.jpg');
 cpselect(moving,fixed);
%%
 im1_pts = movingPoints;
 im2_pts = fixedPoints; 
 %im2_pts = [1,1;16,1;16,543;1,543];
 % compute H and do the warping
 H = computeH(im1_pts,im2_pts);
 im_warped = warpImage(imresize(im,0.5),H);
 %%
 imshow(im_warped);
 %%
 imwrite(im_warped,'ExCap/flock_h.JPG');