% starter script for project 3
DO_TOY = false;
DO_BLEND = true;
DO_MIXED  = false;
DO_COLOR2GRAY = false;

if DO_TOY 
    toyim = im2double(imread('toy_problem.png')); 
    % im_out should be approximately the same as toyim
    im_out = toy_reconstruct(toyim);
    imshow(im_out);
    disp(['Error: ' num2str(sqrt(sum(toyim(:)-im_out(:))))])
end

if DO_BLEND
    im_background = imresize(im2double(imread('www/img/cali.jpg')), 0.9, 'bilinear');
    im_object = imresize(im2double(imread('www/img/tardis.jpg')), 0.9, 'bilinear');
    im_object = imresize(im_object, 0.8);
    % get source region mask from the user
    objmask = getMask(im_object);
    % align im_s and mask_s with im_background
    [im_s, mask_s] = alignSource(im_object, objmask, im_background);

    % blend
    %im_blend = poissonBlend(im_s, mask_s, im_background);
    %figure(3), hold off, imshow(im_blend)
end

if DO_MIXED
    im_background = imresize(im2double(imread('floral-paper-canvas-or-parchment.jpg')), 0.5, 'bilinear');
    im_object = imresize(im2double(imread('IMG_1342.JPG')), 0.5, 'bilinear');
    im_object = imresize(im_object, 0.8);
    % get source region mask from the user
    objmask = getMask(im_object);
    % align im_s and mask_s with im_background
    [im_s, mask_s] = alignSource(im_object, objmask, im_background);
    
    % blend
    im_blend = poissonBlendMixedGradients(im_s, mask_s, im_background, 5, 5);
    figure(3), hold off, imshow(im_blend);
end

if DO_COLOR2GRAY
    im_rgb = im2double(imread('colorBlindTest35.png'));
    im_gr = Color2Grey(im_rgb);
    figure(4), hold off, imagesc(im_gr), axis image, colormap gray
end
