load('movingPoints.mat');
load('fixedPoints.mat');
load('meanPos.mat');
%%
im1 = im2double(imread('IM.JPG'));
im2 = im2double(imread('Harry-Potter-and-The-Chamber-of-Secrets copy.jpg'));
im1_pts = movingPoints1;
im2_pts = fixedPoints1;
tri = delaunay(meanPos(:,1),meanPos(:,2));
%%
if ~exist('morph3', 'dir')
  mkdir('morph3');
end
%%
for f = 23/48:1/48:1
warp_frac = f;
dissolve_frac = f;
%%
morphed_im = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac);
if f*48<10
    imwrite(morphed_im,['morph3/' 'morph0' int2str(48*f) '.jpg']);
else
    imwrite(morphed_im,['morph3/' 'morph' int2str(48*f) '.jpg']);
end
end