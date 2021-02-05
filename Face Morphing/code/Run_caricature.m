fileID = fopen(fullfile('txt','medee.txt'),'r');
    formatSpec = '%f';
    sizeA = [2, 43];
    A = fscanf(fileID,formatSpec,sizeA);
    A = A';
%     temp = A(:,1);
%     A(:,1) = A(:,2);
%      A(:,2) = temp;
% temp = img_pts{19,2}(:,1);
% img_pts{19,2}(:,1) = img_pts{19,2}(:,2);
% img_pts{19,2}(:,2) = temp;
    
load('Avg.mat');
load('Avg_tri.mat');
im1 = im2double(imread('15463-f15-resize/medee.JPG'));
im2 = im2double(imread('morph/meanFace.JPG'));
im1_pts = A;
im2_pts = Avg;


if ~exist('morph', 'dir')
  mkdir('morph');
end


warp_frac = 0;
dissolve_frac = 1;
%%
morphed_im = caricature(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac);
%im_background = im2double(imread('wall.jpg'));
%im_background = im_background(:,129:1408,:);
im_cara = feather(morphed_im);
imshow(im_cara);
imwrite(im_cara,['morph/' 'morph_cara' '.jpg']);