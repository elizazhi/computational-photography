workingDir = 'hologram';
shuttleVideo = VideoReader('hologram.mp4');
ii = 1;

while hasFrame(shuttleVideo)&& ii<=60
   img = readFrame(shuttleVideo);
   filename = [sprintf('%03d',ii) '.jpg'];
   fullname = fullfile(workingDir,filename);
   imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   ii = ii+1;
end
