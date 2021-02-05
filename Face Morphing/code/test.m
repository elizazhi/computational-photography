%morphed_im = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac);
load('chaoyues.mat');
load('yizhizha.mat');
load('Mean.mat');
im1 = im2double(imread('yizhizha.JPG'));
im2 = im2double(imread('chaoyues.JPG'));
im1_pts = movingPoints;
im2_pts = fixedPoints;
tri = delaunay(meanPos(:,1),meanPos(:,2));
warp_frac = 0.5;
dissolve_frac = 0.5;

im_pts = warp_frac*(im2_pts - im1_pts) + im1_pts;
%% 
tri1_pts = zeros(3,2);
tri2_pts = zeros(3,2);
tri3_pts = zeros(3,2);
% each column of af is a set of params for a triangle
af1 = zeros(6, size(tri,1));
af2 = zeros(6, size(tri,1));

for j = 1:size(tri,1)
    for i=1:3
    tri1_pts(i,:) = im1_pts(tri(j,i),:);
    tri3_pts(i,:) = im2_pts(tri(j,i),:);
    tri2_pts(i,:) = im_pts(tri(j,i),:);
    end
    A1 = computeAffine(tri2_pts,tri1_pts);
    af1(:,j) = A1;
    A2 = computeAffine(tri2_pts,tri3_pts);
    af2(:,j) = A2;
end

%% points in which triangle
Y = zeros(size(im1,1),size(im1,2));
X = zeros(size(im1,1),size(im1,2));
for i = 1:size(im1,1)
    Y(i,:) = i;
end
for i = 1:size(im1,2)
    X(:,i) = i;
end

X = reshape(X,[1,size(im1,1)*size(im1,2)]);
Y = reshape(Y,[1,size(im1,1)*size(im1,2)]);
%[t1] = mytsearch(im1_pts(:,1),im1_pts(:,2),tri,X,Y);
[t2] = mytsearch(im_pts(:,1),im_pts(:,2),tri,X,Y);
T1 = reshape(t2,[size(im1,1),size(im1,2)]);
T2 = reshape(t2,[size(im2,1),size(im2,2)]);

%% apply affine on the points according to which tri they belong
im1_cor = zeros(size(T1));
new_im = zeros(size(im1));
im2_cor = zeros(size(T2));
for i = 1:size(T1,1)
    for j = 1:size(T1,2)
        if ~isnan(T1(i,j))
        a1 = reshape(af1(:,T1(i,j)),3,[])';
        a2 = reshape(af2(:,T1(i,j)),3,[])';
        im1_cor=a1*[j;i;1];
        im2_cor = a2*[j;i;1];
        new_im(i,j,:) = dissolve_frac*im1(round(im1_cor(2)),round(im1_cor(1)),:)+(1-dissolve_frac)*im2(round(im2_cor(2)),round(im2_cor(1)),:);
        end
    end
end

%morphed_im*dissolve_frac + B*(1-dissolve_frac)
