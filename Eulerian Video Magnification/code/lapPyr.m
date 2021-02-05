function Lpyramid = lapPyr(I, N)
% I - image to process
% N - levels of pyramid
% Lpyramid - The Laplacian pyramid

%imname = 'baby_images/001.jpg';
% read in the image
%I = imread(imname);
%N = 6;

Gpyramid = cell(N,1);
Gpyramid{1} = im2double(I);
for i = 1:N-1
    Gpyramid{i+1} = impyramid(Gpyramid{i}, 'reduce');
end
% resize each level ready for upscale
Lpyramid = Gpyramid;
for ii = N:-1:2 
	psize = size(Lpyramid{ii})*2-1;
	Lpyramid{ii-1} = Lpyramid{ii-1}(1:psize(1),1:psize(2),:);
end

% calculate Laplacian pyramid by getting the difference between two
% adjacent Gaussian filtered levels
for iii = 1:N-1
	Lpyramid{iii} = Lpyramid{iii}-impyramid(Lpyramid{iii+1}, 'expand');
end
end
