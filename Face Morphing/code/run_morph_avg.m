load('yizhizha.mat');
load('Avg.mat');
load('Avg_tri.mat');
im1 = im2double(imread('15463-f15-resize/yizhizha.JPG'));
im2 = im2double(imread('morph/meanFace.JPG'));
im1_pts = movingPoints;
im2_pts = Avg;
%tri = delauny(meanPos(:,1),meanPos(:,2));

if ~exist('morph_avg', 'dir')
  mkdir('morph_avg');
end

for f = 0:1/60:1
warp_frac = f;
dissolve_frac = f;
%%
morphed_im = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac);
if 60*f<10
    imwrite(morphed_im,['morph_avg/' 'morph_avg0' int2str(60*f) '.jpg']);
else
    imwrite(morphed_im,['morph_avg/' 'morph_avg' int2str(60*f) '.jpg']);
end
end