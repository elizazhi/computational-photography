im = im2double(imread('scream_1893.jpg'));
addpath('part3/');
addpath('../code/');
%% getting the 5 walls and vanishing point
[vx, vy, irx, iry, orx, ory] = TIP_GUI(im);
%%
[big_im,big_im_alpha,vx,vy,ceilrx,ceilry,floorrx,floorry,...
    leftrx,leftry,rightrx,rightry,backrx,backry] = ...
    TIP_get5rects(im,vx,vy,irx,iry,orx,ory);

%% size
h = iry(4)-iry(1);
w = irx(2)-irx(1);
D = ceil(max(size(im,1), size(im,2)));

%% left-wall
left_wall = [1,1;1+D,1;1+D,1+h;1,1+h];
%im_left = big_im(ceilry(1):floorry(4),1:backrx(1),:);
  
  H_l = computeH([leftrx;leftry]',left_wall);
  
 im_left = warpImage_fixedSize(big_im,H_l, h+1, D+1);
 imshow(im_left);
% imwrite(im_left,'sf_left.jpg');
 
 %% right-wall
 right_wall = [1,1;1+D,1;1+D,1+h;1,1+h];
  
  H_r = computeH([rightrx;rightry]',right_wall);
  
 im_right = warpImage_fixedSize(big_im,H_r, h+1, D+1);
 imshow(im_right);
 %%
 %%imwrite(im_right,'sf_right.jpg');

 %% ceiling
 ceil_wall = [1,1;1+w,1;1+w,1+D;1,1+D];
  H_c = computeH([ceilrx;ceilry]',ceil_wall);
  
 im_ceil = warpImage_fixedSize(big_im,H_c, D+1, w+1);
 imshow(im_ceil);
 %%
 imwrite(im_ceil,'sf_ceil.jpg');
 
 %% floor
 floor_wall = [1,1;1+w,1;1+w,1+D;1,1+D];
  H_f = computeH([floorrx;floorry]',floor_wall);
  
 im_floor = warpImage_fixedSize(big_im,H_f, D+1, w+1);
 imshow(im_floor);
 %%
 imwrite(im_floor,'sf_floor.jpg');
 %% back-wall
 im_back = big_im(backry(1):backry(4),backrx(1):backrx(2),:);
 %%imwrite(im_back,'sf.jpg');
 
 %%
 fore = im2double(imread('hPlane.jpg'));
 mask =rgb2gray(im2double(imread('mask2.jpg')));
 fore_pos = (5.555/18.376)*D;
 %% make the box
%% define a surface in 3D (need at least 6 points, for some reason)
planex = [D D D; D D D];
planey = [-w -w/2 0; -w -w/2 0];
planez = [h h h; 0 0 0];
% create the surface and texturemap it with a given image
%warp(planex,planey,planez,im_back);
%hold on;
planex_l = [0 D/2 D; 0 D/2 D];
planey_l = [-w -w -w; -w -w -w];
planez_l = [h h h; 0 0 0];
warp(planex_l,planey_l,planez_l,im_left);

planex_r = [D D/2 0; D D/2 0];
planey_r = [0 0 0; 0 0 0];
planez_r = [h h h; 0 0 0];
warp(planex_r,planey_r,planez_r,im_right);
hold on;
planex_c = [0 0 0; D D D];
planey_c = [-w -w/2 0; -w -w/2 0];
planez_c = [h h h; h h h];
warp(planex_c,planey_c,planez_c,im_ceil);

planex_f = [D D D; 0 0 0];
planey_f = [-w -w/2 0; -w -w/2 0];
planez_f = [0 0 0; 0 0 0];
warp(planex_f,planey_f,planez_f,im_floor);

% planex_fore = [fore_pos fore_pos fore_pos; fore_pos fore_pos fore_pos];
% planey_fore = [-w -w/2 0; -w -w/2 0];
% planez_fore = [h h h; 0 0 0];
% warp(planex_fore,planey_fore,planez_fore,fore);
% alpha(mask);
% alpha('texture');

%axis vis3d;  % freeze the scale for better rotations
axis off;    % turn off the stupid tick marks
camproj('perspective');  % make it a perspective projection
%%
camva(camva/3)
%camdolly(D/2,-w/2,h/2,'fixtarget','data')
M = moviein(300);

for i=1:80
   camdolly(-1,-30,-30,'fixtarget','data')
   %camorbit(5,0,'data',[0,0,1])
   drawnow
   M(i)=getframe(gcf); 
end


%% set 2
% create the surface and texturemap it with a given image
warp(planex,planey,planez,im_back);
hold on;
warp(planex_l,planey_l,planez_l,im_left);
warp(planex_c,planey_c,planez_c,im_ceil);
warp(planex_f,planey_f,planez_f,im_floor);
warp(planex_fore,planey_fore,planez_fore,fore);
alpha(mask);
alpha('texture');

axis vis3d;  % freeze the scale for better rotations
axis off;    % turn off the stupid tick marks
camproj('perspective');  % make it a perspective projection

camva(camva/3)
%camdolly(D/2,-w/2,h/2,'fixtarget','data')

for i=1:80
   camdolly(-1,-30,-30,'fixtarget','data')
   %camorbit(5,0,'data',[0,0,1])
   drawnow
 %  M(i)=getframe(gcf); 
end

for i=81:160
   camdolly(0,0,-6,'fixtarget','data')
   camorbit(1,0.6,'data',[0,0,1])
   drawnow
   M(i)=getframe(gcf);  
end

for i=161:230
   camdolly(-1,-5,0,'fixtarget','data')
   camorbit(-1.5,0,'data',[0,0,1])
   drawnow
   M(i)=getframe(gcf);  
end
%%
% create the surface and texturemap it with a given image
warp(planex,planey,planez,im_back);
hold on;
warp(planex_r,planey_r,planez_r,im_right);
warp(planex_c,planey_c,planez_c,im_ceil);
warp(planex_f,planey_f,planez_f,im_floor);
warp(planex_fore,planey_fore,planez_fore,fore);
alpha(mask);
alpha('texture');

axis vis3d;  % freeze the scale for better rotations
axis off;    % turn off the stupid tick marks
camproj('perspective');  % make it a perspective projection

camva(camva/3)
%camdolly(D/2,-w/2,h/2,'fixtarget','data')

for i=1:80
   camdolly(-1,-30,-30,'fixtarget','data')
   %camorbit(5,0,'data',[0,0,1])
   drawnow
 %  M(i)=getframe(gcf); 
end

for i=1:80
   camdolly(0,0,-6,'fixtarget','data')
   camorbit(1,0.6,'data',[0,0,1])
   drawnow
 %  M(i)=getframe(gcf);  
end

for i=1:70
   camdolly(-1,-5,0,'fixtarget','data')
   camorbit(-1.5,0,'data',[0,0,1])
   drawnow
 %  M(i)=getframe(gcf);  
end
for i=231:300
   camdolly(-0.5,-2,0,'fixtarget','data')
   camorbit(-1.5,0,'data',[0,0,1])
   drawnow
   M(i)=getframe(gcf);  
end

%%
movie2avi(M, 'art.avi');