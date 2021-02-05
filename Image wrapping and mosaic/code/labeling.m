%% labeling ---- 1
moving = imread('my pics/FullSizeRender.jpg');
fixed = imread('my pics/FullSizeRender.jpg');
cpselect(moving,fixed);
%%
save('movingPoints.mat','movingPoints');
%%
fixedPoints2(1,:) = movingPoints(1,:);
fixedPoints2(2,1) = movingPoints(1,1);
fixedPoints2(2,2) = movingPoints(1,2)+2500;
fixedPoints2(3,1) = fixedPoints2(2,1)+2500;
fixedPoints2(3,2) = fixedPoints2(2,2);
fixedPoints2(4,1) = fixedPoints2(3,1);
fixedPoints2(4,2) = fixedPoints2(3,2)-2500;
%%
save('fixedPoints.mat','fixedPoints');

%% -----2
% labeling
moving = imresize(imread('my pics/IMG_1692.JPG'),0.5);
fixed = imresize(imread('my pics/IMG_1692.jpg'),0.5);
cpselect(moving,fixed);
%%
save('movingPoints.mat','movingPoints');
%%
fixedPoints = [1,201;201,201;201,1;1,1];
%%
save('fixedPoints.mat','fixedPoints');

%% ----- 3
% labeling
moving = imresize(imread('my pics/001.JPG'),0.5);
fixed = imresize(imread('my pics/002.jpg'),0.5);
cpselect(moving,fixed);
%%
save('movingPoints.mat','movingPoints');
save('fixedPoints.mat','fixedPoints');