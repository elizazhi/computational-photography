im=im2double(imread('night.jpg'));
f=fspecial('unsharp',0.5);
im_sharp = zeros(size(im));
for c = 1:3
im_sharp(:,:,c)=filter2(f,im(:,:,c));
end
imshow(im);
figure;
imshow(im_sharp);