function im_planet = morphToGlobe_quick(im, size_factor, blend_factor,bulge_factor)
%factor all between 0 and 1;
%size factor 0.4 best
% blend_factor = 0.1;
% size_factor = 0.4;
% bulge_factor = 0.1;
im = im2double(im);
%im = imresize(im, 0.5);

width = size(im, 2);
height = size(im, 1);
r = height;

%% on all three channels
%factor = 0.4; % between 0 and 1
V = [1:(2*r-1)*(2*r-1)];
[I,J] = ind2sub([(2*r-1),(2*r-1)],V);
x = I-r;
y = r-J;
[theta,rho] = cart2pol(x,y);
%im1 = zeros((2*r-1),(2*r-1));
im_warped=zeros((2*r-1),(2*r-1),3);
%             
COL1  = zeros(1,length(x));
COL2  = zeros(1,length(x));
ROW = zeros(1,length(x));
blend_index = rho < height & theta< blend_factor/(1-blend_factor)*2*pi & theta >= 0;
%%
COL1(blend_index) = width - theta(blend_index)/(2*pi) * (1-blend_factor)* width;
COL2(blend_index) = COL1(blend_index)-(1-blend_factor)*width;

bulge = bulgeFn(bulge_factor, size_factor, rho/height);
ROW = (height - height* bulge)';
good_idx = COL1>0 & COL2>0 & ROW>0;
index_not_blend = J<=r;
index_right = J>r;

COL1(index_right) = width - (2*pi+theta(index_right))/(2*pi) * (1-blend_factor)*width;
V_right = sub2ind([(2*r-1),(2*r-1)], I(index_right), J(index_right));
%index_not_blend = and(index_not_blend,not(blend_index));
index_blend = and(blend_index,good_idx);
index_blend = and(index_blend,theta< blend_factor*0.9/(1-blend_factor)*2*pi);
V_blend = sub2ind([(2*r-1),(2*r-1)], I(index_blend), J(index_blend));
COL1(index_not_blend) = width - theta(index_not_blend)/(2*pi) * (1-blend_factor)* width;
%index_not_blend = and(index_not_blend,good_idx);
V_not_blend = sub2ind([(2*r-1),(2*r-1)], I(index_not_blend), J(index_not_blend));
%%
for c = 1:3
im1 = zeros((2*r-1),(2*r-1));
im1(V_right)= interp2(im(:,:,c), COL1(V_right),ROW(V_right));
im1(V_not_blend) = interp2(im(:,:,c), COL1(V_not_blend),ROW(V_not_blend));
im1(V_blend) = bsxfun(@times,theta(V_blend)/(blend_factor/(1-blend_factor)*2*pi),interp2(im(:,:,c), COL1(V_blend),ROW(V_blend)))...
    +bsxfun(@times,(1-theta(V_blend)/(blend_factor/(1-blend_factor)*2*pi)),interp2(im(:,:,c), COL2(V_blend),ROW(V_blend)));
%im1(V_not_blend) = interp2(im(:,:,c), COL1(V_not_blend),ROW(V_not_blend));
im_warped(:,:,c) = im1;
end
im_planet = im_warped(ceil(height*(sqrt(2)-1)):2*height-1-ceil(height*(sqrt(2)-1)),ceil(height*(sqrt(2)-1)):2*height-1-ceil(height*(sqrt(2)-1)),:);

        
        