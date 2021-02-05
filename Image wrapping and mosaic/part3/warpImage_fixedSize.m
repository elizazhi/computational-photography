function im_warped = warpImage_fixedSize(im,H, h, w)
 %%
% rows = size(im,1);
% cols = size(im,2);
% im = big_im;
% H = H_l;
% h = h+1;
% w = D+1;
 im_warped = zeros(h, w,3);
%%
V = [1:h*w];
[I,J] = ind2sub([h,w],V);
b = [J; I; ones(1,h*w)];
im_cor = H\b;
im_cor = bsxfun(@rdivide,im_cor,im_cor(end,:));
%%
for c = 1:3
%im1 = zeros(h,w);
im1 = interp2(im(:,:,c), im_cor(1,:),im_cor(2,:));
im_warped(:,:,c) = reshape(im1,[h w]);
end
