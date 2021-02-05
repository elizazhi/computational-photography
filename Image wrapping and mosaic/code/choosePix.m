function im_MaxGrad = choosePix(im_new1,im_new2)
im1 = rgb2gray(im_new1);
im2 = rgb2gray(im_new2);
G1_1 = impyramid(im1, 'reduce');
G1_2 = impyramid(G1_1, 'reduce');
L1 = G1_1 - impyramid(G1_2,'expand');

G2_1 = impyramid(im2, 'reduce');
G2_2 = impyramid(G2_1, 'reduce');
L2 = G2_1 - impyramid(G2_2,'expand');

idx = L1>L2;
mask = impyramid(idx,'expand');
if(size(mask,1)<size(im1,1))
    mask = [mask;mask(end,:)];
end
if (size(mask,2)<size(im1,2))
     mask = [mask,mask(:,end)];
end
if (size(mask,2)>size(im1,2))
     mask = mask(:,1:end-1);
end
if (size(mask,1)>size(im1,1))
     mask = mask(1:end-1,:);
end
im_MaxGrad = im_new1.*repmat(mask,[1,1,3])+im_new2.*repmat((1-mask),[1,1,3]);
end