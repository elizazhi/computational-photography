imageNames = dir('xiaowei_amp/*.jpg');
imageNames = {imageNames.name}';

outputVideo = VideoWriter('xiaowei_amp.mp4');
outputVideo.FrameRate = 25;
open(outputVideo);

for ii = 1:length(imageNames)
   img = imread(fullfile('xiaowei_amp',imageNames{ii}));
   writeVideo(outputVideo,img);
end

close(outputVideo);