%% labeling
moving = imread('IM.JPG');
fixed = imread('Harry-Potter-and-The-Chamber-of-Secrets copy.jpg');
cpselect(moving,fixed);

%% read txt file into two columns
fileID = fopen('txt/yizhizha.txt','r');
formatSpec = '%f';
sizeA = [2, 43];
A = fscanf(fileID,formatSpec,sizeA);
A = A';

%% Calculating the mean
meanPos = zeros(112,2);
for i = 1:112
    meanPos(i, 1) = (movingPoints1(i, 1)+fixedPoints1(i,1))/2;
    meanPos(i, 2) = (movingPoints1(i, 2)+fixedPoints1(i,2))/2;
end

%% varify
difPos = zeros(92,2);
for i = 1:92
    difPos(i, 1) = (movingPoints(i, 1)-fixedPoints(i,1));
    difPos(i, 2) = (movingPoints(i, 2)-fixedPoints(i,2));
end

%% drawing triangles
TRI = delaunay(meanPos(:,1),meanPos(:,2));
%triplot(TRI,meanPos(:,1),meanPos(:,2));