shuttleVideo = VideoReader('img/MVI_1779.MOV');
frames = shuttleVideo.Duration*shuttleVideo.FrameRate;
M = moviein(frames);
%%
im1 = imresize(im2double(imread('img/034.jpg')),0.5);
im2 = imresize(im2double(imread('img/048.jpg')),0.5);
[a1,angle] = rotateIM(im1,im2);
cropping = size(im2,2)*sin(angle);
im_rotated = imrotate(im2,a1-pi,'bicubic');
im_rotated_crop = im_rotated(cropping+1:size(im_rotated,1)-cropping,cropping+1:size(im_rotated,2)-cropping,:);
figure;
imshow(im_rotated_crop);
%%
imshow(crop_rotated(im_rotated));
%%
ii = 1;
while hasFrame(shuttleVideo)
        img = readFrame(shuttleVideo);
        %im_rotated = imrotate(img,a1-pi,'bicubic');
        %im_rotated_crop = im_rotated(cropping+1:size(im_rotated,1)-cropping,cropping+1:size(im_rotated,2)-cropping,:);
        im_p = morphToGlobe_quick(img,0.5,0.1,0.15);
        imshow(im_p);
        M(ii)=getframe(gcf); 
       % filename = [sprintf('%03d',ii) '.jpg'];
       % fullname = fullfile('img',filename);
       % imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   % end
    ii = ii+1;
end
%%
movie2avi(M, 'img/flagstaff-2.avi');