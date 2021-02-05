% getting the image files
files= dir('xiaowei_images/*.jpg');
N = size(files,1);
% making a file to store the 6 levels of pyramids
pyr = cell(6, 1);
% making a time series file to store 6 levels of pyramids
%T = cell(6,1);

fullim = imread(fullfile('xiaowei_images',files(1).name));
lpyr = lapPyr(fullim, 6);
for p = 1:6
    sz = size(lpyr{p});
    pyr{p} = zeros([sz N]);
    pyr{p}(:,:,:,1)= lpyr{p};
   % T{p} = zeros([prod(sz(1:2)) N 3]);
   % T{p}(:,:,1) = reshape(pyr{p}(:,:,1,:), [prod(sz(1:2)) N]);
   % T{p}(:,:,2) = reshape(pyr{p}(:,:,2,:), [prod(sz(1:2)) N]);
   % T{p}(:,:,3) = reshape(pyr{p}(:,:,3,:), [prod(sz(1:2)) N]);
end

for file = 2:N
% name of the input file
imname = files(file).name;
% read in the image
fullim = imread(fullfile('xiaowei_images',imname));
lpyr = lapPyr(fullim, 6);
for p = 1:6
    sz = size(lpyr{p});
    pyr{p}(:,:,:,file)= lpyr{p};
   % T{p}(:,:,1) = reshape(pyr{p}(:,:,1,:), [prod(sz(1:2)) N]);
   % T{p}(:,:,2) = reshape(pyr{p}(:,:,2,:), [prod(sz(1:2)) N]);
   % T{p}(:,:,3) = reshape(pyr{p}(:,:,3,:), [prod(sz(1:2)) N]);
end
end
