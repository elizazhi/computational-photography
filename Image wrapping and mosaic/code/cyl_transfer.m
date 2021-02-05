function new_im1 = cyl_transfer(im1,r)
% %%
% im1 = im2double(imread('my pics/101.JPG'));
% fx = 2540.39;
% fy = 2543.93;
% r = (fx+fy)/2;
%%
[h, w, c] = size(im1);
x_c = w/2;
y_c = h/2;
%%
x1 = r * tan((1-x_c)/r)+x_c;
y1 = (1-y_c)/cos((1-x_c)/r) + y_c;

x2 = r * tan((w-x_c)/r)+x_c;
y2 = y1;

x3 = x2;
y3 = (h-y_c)/cos((w-x_c)/r) + y_c;

x4 = x1;
y4 = (h-y_c)/cos((1-x_c)/r) + y_c;

h_offset = 1-x1;
v_offset = 1-y1;
%%
new_h = ceil(y4-y1);
new_w = ceil(x2-x1);
new_im1 = zeros(new_h, new_w, 3);
% %%
% for i = 1:new_w
%     for j = 1:new_h
%         x_cyl = i-h_offset;
%         y_cyl = j-v_offset;
%         x_car = round(atan((x_cyl-x_c)/r)*r+x_c);
%         y_car = round((y_cyl-y_c)*cos((x_car-x_c)/r)+y_c);
%         if(x_car<1||y_car<1||x_car>w||y_car>h)
%             new_im1(j,i,:) = [0;0;0];
%         else
%         new_im1(j,i,:) = im1(y_car,x_car,:);
%         end
%     end
% end
% imshow(new_im1);
% %%
%%
V = [1:new_h*new_w];
[I,J] = ind2sub([new_h,new_w],V);
JJ = J-h_offset;
II = I-v_offset;
X_car = round(atan((JJ-x_c)/r)*r+x_c);
Y_car = round(bsxfun(@times,(II-y_c),cos((X_car-x_c)/r))+y_c);
%%
good_index = X_car>=1 & X_car<=w & Y_car>=1 & Y_car<=h;
V_good = sub2ind([new_h,new_w], I(good_index), J(good_index));
%%
for c = 1:3
im2 = zeros(new_h,new_w);
im2(V_good) = interp2(im1(:,:,c), X_car(good_index),Y_car(good_index));
new_im1(:,:,c) = im2;
end