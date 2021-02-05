%workingDir = 'smokyM';
shuttleVideo = VideoReader('MVI_1755.MOV');
ii = 1;
frames = shuttleVideo.framerate * shuttleVideo.duration;
M = moviein(frames);
%%
while hasFrame(shuttleVideo) && ii<2
   img = im2double(imresize(readFrame(shuttleVideo),0.5));
   img_out = morphToGlobe(img, 0.5, 0.1, 0);
   %filename = [sprintf('%03d',ii) '.jpg'];
  % fullname = fullfile(workingDir,filename);
  
   %imwrite(img_out,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   imshow(img_out);
  % M(ii)=getframe(gcf); 
   ii = ii+1;
end

%%
 img = im2double(imresize(imread('IMG_1724.JPG'),0.5));
 img_out = morphToGlobe(img, 0.4, 0.1, 0);
 imshow(img_out);