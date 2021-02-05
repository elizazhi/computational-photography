%function meanIm = meanFace(img_pts,tri);
%load('chaoyues.mat');
%load('yizhizha.mat');
%load('Mean.mat');
% imageNames = img_pts{:,1};
% imageNames = dir('15463-f15-resize/*.JPG');
% imageNames = {imageNames.name}';
% %%
% im = im2double(imread('15463-f15-resize/*.JPG'));
% 
% im1_pts = movingPoints;
% im2_pts = fixedPoints;
% tri = delaunay(Avg(:,1),Avg(:,2));
%%
N = length(img_pts);
im_pts = Avg;
size_im = size(img_pts{1,3});
%% 
tri1_pts = zeros(3,2);
tri2_pts = zeros(3,2);

% each column of af is a set of params for a triangle
% initializing
af = cell(N,1);
for i = 1:N
    af{i} = zeros(6, size(tri,1));
end

for m = 1:N
    for j = 1:size(tri,1)
        for i=1:3
        tri1_pts(i,:) = img_pts{m,2}(tri(j,i),:);
        tri2_pts(i,:) = im_pts(tri(j,i),:);
        end
        A = computeAffine(tri2_pts,tri1_pts);
        af{m}(:,j) = A;
    end
end
%% points in which triangle
Y = zeros(size_im(1),size_im(2));
X = Y;
for i = 1:size_im(1)
    Y(i,:) = i;
end
for i = 1:size_im(2)
    X(:,i) = i;
end

X = reshape(X,[1,size_im(1)*size_im(2)]);
Y = reshape(Y,[1,size_im(1)*size_im(2)]);

[t] = mytsearch(im_pts(:,1),im_pts(:,2),tri,X,Y);
T = reshape(t,[size_im(1),size_im(2)]);
%% apply affine on the points according to which tri they belong
im_cor = cell(N,1);
for i = 1:N
    im_cor{i} = zeros(size(T));
end
meanIm = zeros(size_im); % output mean face


cor = zeros(N,3);
%%
for i = 1:size(T,1)
    for j = 1:size(T,2)
        if ~isnan(T(i,j))
            for m = 1:N
                a = reshape(af{m}(:,T(i,j)),3,[])';
                im_cor{m}=a*[j;i;1];
                cor(m,:) = img_pts{m,3}(round(im_cor{m}(2)),round(im_cor{m}(1)),:);
            end
        % cross-dissolve    
       meanIm(i,j,1) = mean(cor(:,1));    
       meanIm(i,j,2) = mean(cor(:,2)); 
       meanIm(i,j,3) = mean(cor(:,3)); 
        end
    end
end
%%
meanIm1 = feather(meanIm);
imshow(meanIm1);
imwrite(meanIm,'meanFace.jpg');
%save('Avg.mat','Avg');
%save('Avg.mat','Avg');
%save('Avg_tri.mat','tri');