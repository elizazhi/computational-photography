function new_img = Color2Grey(im_rgb);
%im_rgb = im2double(imread('colorBlindTest35.png'));
%%
%im_rgb = im2double(imread('colorBlindTest35.png'));
im_s = rgb2hsv(im_rgb);
%im1 = im_s(:,:,1);
im2 = im_s(:,:,2);
im3 = im_s(:,:,3);
%im_g = rgb2gray(im_rgb);
%im3 = im_s(:,:,3);

[imh, imw] = size(im2); 
im2var = zeros(imh, imw); 
im2var(1:imh*imw) = 1:imh*imw; 

s = im3;
im_b = im2;
%%

%% blending(solve for V)

maxV = max(im2var(:));
A = sparse([], [], [], imh*(imw-1)+imw*(imh-1)+1, maxV, 2*(imh*(imw-1)+imw*(imh-1)+1));
b = zeros(imh*(imw-1)+imw*(imh-1)+1,1);
%%
e = 0;
for y = 1:imh
   for x = 1:imw-1
%% Obj 1 for im_in
e = e + 1;
A(e, im2var(y,x+1))=1; 
A(e, im2var(y,x))=-1; 
b(e) = gradientMax(s(y,x+1), s(y,x), im_b(y,x+1), im_b(y,x));
   end
end
%% Obj 2 
for x = 1:imw
   for y = 1:imh-1
e = e + 1;
A(e, im2var(y+1,x))=1; 
A(e, im2var(y,x))=-1; 
b(e) = gradientMax(s(y+1,x), s(y,x), im_b(y+1,x), im_b(y,x));
   end
end
%% obj3
e = e + 1;
A(e, im2var(1,1))=1; 
b(e)=s(1,1); 
%%
v = A\b;

%%
new_img = reshape(v, [imh, imw]);
