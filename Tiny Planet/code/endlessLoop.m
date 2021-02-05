shuttleVideo = VideoReader('img/5th_auto.avi');
frames = shuttleVideo.Duration*shuttleVideo.FrameRate;
img_diff = zeros(frames-1,1);
%%
img = read(shuttleVideo,frames);

for f=1:frames-1
otherframe = read(shuttleVideo, f);
diff = rgb2gray(img)-rgb2gray(otherframe);
img_diff(f) = sum(diff(:).^2);
end

%%
min_idx = find(img_diff==min(img_diff));
%%
M = moviein(frames-min_idx+1);
for f=min_idx+1:frames
otherframe = read(shuttleVideo, f);
imshow(otherframe);
M(f-min_idx)=getframe(gcf); 
end
%%
movie2avi(M, 'img/5th_auto_endless.avi');