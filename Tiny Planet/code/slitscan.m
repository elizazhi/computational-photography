shuttleVideo = VideoReader('img/MVI_1774.MOV');
frames = shuttleVideo.Duration*shuttleVideo.FrameRate;
%%
im1 = imresize(im2double(imread('img/034.jpg')),0.5);
im2 = imresize(im2double(imread('img/048.jpg')),0.5);
[a1,angle] = rotateIM(im1,im2);
cropping = size(im2,2)*sin(angle);
im_rotated = imrotate(im2,a1-pi,'bicubic');
im_rotated_crop =crop_rotated(im_rotated);
%im_rotated_crop = im_rotated(cropping+1:size(im_rotated,1)-cropping,cropping+1:size(im_rotated,2)-cropping,:);

%%
img = imrotate(imresize(read(shuttleVideo,1),0.5),a1-pi,'bicubic');
img_c = crop_rotated(img(5:size(img,1)-5,5:size(img,2)-5,:));
blend_factor = 0.1;
img_c = rgb2gray(img_c);
slit = round(size(img_c,2)-blend_factor/(1-blend_factor)*size(img_c,2)+1);
%%
img_diff1 = zeros(frames-1,1);
img_diff2 = zeros(frames-1,1);
for f=2:frames
otherframe = rgb2gray(read(shuttleVideo, f));
im = imrotate(imresize(otherframe,0.5),a1-pi,'bicubic');
im_c = crop_rotated(im(5:size(im,1)-5,5:size(im,2)-5,:));
diff1 = img_c(:,slit)-im_c(:,slit);
img_diff1(f) = sum(diff1.^2);
diff2 = img_c(:,1)-im_c(:,1);
img_diff2(f) = sum(diff2.^2);
end
%%
cutoff = 4000;
for jj=3:length(img_diff1)-1
    difference = abs(img_diff1(jj+1)-img_diff1(jj));
    if difference >= cutoff
        cut1 = jj;
        break;
    end
end
%%
start = cut1;
cutoff = 3000;
for jj=length(img_diff1)-1:-1:start+1
    difference = img_diff1(jj)-img_diff1(jj+1);
    if difference <= cutoff
        cut2 = jj;
        break;
    end
end
ending = cut2;
%%
for jj=2:length(img_diff2)-1
    difference = abs(img_diff2(jj+1)-img_diff2(jj));
    if difference >= cutoff
        cut1_end = jj;
        break;
    end
end
%%
cutoff=4500;
start_end = cut1_end;
for jj=start_end+1:length(img_diff2)-1
    difference = abs(img_diff2(jj+1)-img_diff2(jj));
    if difference >= cutoff
        cut2_end = jj;
        break;
    end
end
ending_end = cut2_end;
%%
M = moviein(ending_end-start+1);
starting = cell(ending-start+1,1);

for f=start:start_end
otherframe = read(shuttleVideo, f);
im = imrotate(imresize(otherframe,0.5),a1-pi,'bicubic');
im_c = im(cropping+1:size(im,1)-cropping,cropping+1:size(im,2)-cropping,:);
im_p = morphToGlobe_quick(im_c,0.5,0.1,0.15);
if f<=ending
    starting{f-start+1} = im_p;
end
imshow(im_p);
M(f-start+1)=getframe(gcf); 
end
%%
for f=start_end+1:ending_end
otherframe = read(shuttleVideo, f);
im = imrotate(imresize(otherframe,0.5),a1-pi,'bicubic');
im_c = im(cropping+1:size(im,1)-cropping,cropping+1:size(im,2)-cropping,:);
im_p = morphToGlobe_quick(im_c,0.5,0.1,0.15);
if f> ending_end-length(starting)
    im_p = (1-(f-(ending_end-length(starting)))/length(starting))*im_p+(f-(ending_end-length(starting)))/length(starting)*starting{f-(ending_end-length(starting))};
end
    imshow(im_p);
M(f-start+1)=getframe(gcf); 
end
%%
movie2avi(M, 'img/5th_auto.avi');