% read in mass txt files
%% read txt file into two columns
txt = dir('txt/*.txt');
txt = {txt.name}';
%%
X = zeros(43, length(txt));
Y = zeros(43, length(txt));
img_pts = cell(length(txt),3);

legendInfo = cell(length(txt),1);
%%
for i = 1:length(txt)
fileID = fopen(fullfile('txt',txt{i}),'r');
fileName = txt{i};
img_pts{i,1} = fileName;
img_pts{i,3} = im2double(imread(fullfile('15463-f15-resize',strrep(fileName, 'txt','JPG'))));
formatSpec = '%f, %f';
sizeA = [2, 43];
A = fscanf(fileID,formatSpec,sizeA);
 if size(A)==[2,43]
    A = A';
    X(:,i) = A(:,1);
    Y(:,i) = A(:,2);
    img_pts{i,2} = A;
    legendInfo{i} = num2str(i);
 else
    fileID = fopen(fullfile('txt',txt{i}),'r');
    formatSpec = '%f';
    sizeA = [2, 43];
    A = fscanf(fileID,formatSpec,sizeA);
    A = A';
    X(:,i) = A(:,1);
    Y(:,i) = A(:,2);   
    img_pts{i,2} = A;
    legendInfo{i} = num2str(i);
 end
end

%% fixing 11 (to be removed)
temp = X(:,20);
X(:,20) = Y(:,20);
Y(:,20) = temp;
temp = img_pts{20,2}(:,1);
img_pts{20,2}(:,1) = img_pts{20,2}(:,2);
img_pts{20,2}(:,2) = temp;
%% avg points
Avg = zeros(43, 2);
Avg(:,1) = mean(X,2);
Avg(:,2) = mean(Y,2);
%% avg triangle
tri = delaunay(Avg(:,1),Avg(:,2));

plot(X)
legend(legendInfo);