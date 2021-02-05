f = 2543.93*1.5;
im1 = im2double(imread('my pics/360/IMG_1746.JPG'));
im1_c = cyl_transfer(im1,f);

im2 = im2double(imread('my pics/360/IMG_1747.JPG'));
im2_c = cyl_transfer(im2,f);
%%
im3 = im2double(imread('my pics/10.JPG'));
im3_c = cyl_transfer(im3,f);
%%
figure;
imshow(im1_c);
figure;
imshow(im2_c);
%%
figure;
imshow(im3_c);