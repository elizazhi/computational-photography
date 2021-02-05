%workingDir = 'hologram';
shuttleVideo = VideoReader('img/MVI_1756.MOV');
frames = shuttleVideo.Duration*shuttleVideo.FrameRate;
%%
ii = 1;
while hasFrame(shuttleVideo)
        img = readFrame(shuttleVideo);
    if ii==38 || ii==50
        filename = [sprintf('%03d',ii) '.jpg'];
        fullname = fullfile('img',filename);
        imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
    end
    ii = ii+1;
end