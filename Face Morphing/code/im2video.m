imageNames = dir('langyabang/*.jpg');
imageNames = {imageNames.name}';

% outputVideo = VideoWriter('lyb');
% outputVideo.FrameRate = 25;
% open(outputVideo);
% 
%  for ii = 1:length(imageNames)
%     img = imread(fullfile('langyabang',imageNames{ii}));
%     writeVideo(outputVideo,img);
%  end
% 
% close(outputVideo);

%%
% create the video writer with 1 fps
 writerObj = VideoWriter('myVideo.avi','MPEG-4');
 writerObj.FrameRate = 25;
 % set the seconds per image
 %secsPerImage = [5 10 15];
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for u=1:length(imageNames)
     img = imread(fullfile('langyabang',imageNames{u}));
     % convert the image to a frame
     frame = im2frame(img);
    % for v=1:secsPerImage(u) 
     writeVideo(writerObj, frame);
    % end
 end
 % close the writer object
 close(writerObj);