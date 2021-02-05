load('Avg.mat');
%im = rgb2gray(im2double(imread('morph/meanFace.JPG')));
%%
imnames = dir('15463-f15-resize/*.JPG');
imnames = {imnames.name}';

im1 = im2double(imread('morph/meanFace.JPG'));
im1 = im1(:,:,1);
%im1 = imresize(im1,size(im1));
X = zeros(prod(size(im1)),length(imnames));

%%
for i = 1:length(imnames)
    im = rgb2gray(im2double(imread(fullfile('15463-f15-resize',imnames{i}))));
    %im = imresize(im, size(im));
    X(:,i) = reshape(im,[prod(size(im)),1]);
end

%%
[COEFF,SCORE] = princomp(X);

if ~exist('pca', 'dir')
  mkdir('pca');
end

for i =  1:size(SCORE,2)
    imwrite(reshape(SCORE(:,i),size(im)), ['pca/' 'pc_' num2str(i) '.jpg']);
end