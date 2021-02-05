%function im_blend = poissonBlend(im_s, mask_s, im_background);
%im_out = toy_reconstruct(im)
load('im_s.mat');
load('mask_s.mat');
load('im_background.mat');

im = im_s(:,:,1);
[imh, imw, nb] = size(im); 
im2var = zeros(imh, imw); 
im2var(1:imh*imw) = 1:imh*imw; 
%% divide into 3 groups
im_in = im2var;
im_out = im2var;
im_edge = im2var;

for w = 2:imw-1
    for h = 2:imh-1
    if mask_s(h,w)+mask_s(h-1,w)+mask_s(h,w-1)+mask_s(h+1,w)+mask_s(h,w+1)==0
        im_in(h,w) = -1;
        im_edge(h,w)= -1;
    else
        if mask_s(h,w)+mask_s(h-1,w)+mask_s(h,w-1)+mask_s(h+1,w)+mask_s(h,w+1)==5
        im_out(h,w) = -1;
        im_edge(h,w)= -1;
        else
            im_out(h,w) = -1;
            im_in(h,w)= -1;
        end
    end
    end
end
%% edge cases
for w = 2:imw-1
    if mask_s(1,w)+mask_s(1,w-1)+mask_s(2,w)+mask_s(1,w+1)==0
        im_in(1,w) = -1;
        im_edge(1,w)= -1;
    else
        if mask_s(1,w)+mask_s(1,w-1)+mask_s(2,w)+mask_s(1,w+1)==4
        im_out(1,w) = -1;
        im_edge(1,w)= -1;
        else
            im_out(1,w) = -1;
            im_in(1,w)= -1;
        end
    end
end
for w = 2:imw-1
    if mask_s(imh,w)+mask_s(imh,w-1)+mask_s(imh-1,w)+mask_s(imh,w+1)==0
        im_in(imh,w) = -1;
        im_edge(imh,w)= -1;
    else
        if mask_s(imh,w)+mask_s(imh,w-1)+mask_s(imh-1,w)+mask_s(imh,w+1)==4
        im_out(imh,w) = -1;
        im_edge(imh,w)= -1;
        else
            im_out(imh,w) = -1;
            im_in(imh,w)= -1;
        end
    end
end
for h = 2:imh-1
    if mask_s(h,1)+mask_s(h-1,1)+mask_s(h+1,1)+mask_s(h,2)==0
        im_in(h,1) = -1;
        im_edge(h,1)= -1;
    else
        if mask_s(h,1)+mask_s(h-1,1)+mask_s(h+1,1)+mask_s(h,2)==4
        im_out(h,1) = -1;
        im_edge(h,1)= -1;
        else
            im_out(h,1) = -1;
            im_in(h,1)= -1;
        end
    end
end
for h = 2:imh-1
    if mask_s(h,imw)+mask_s(h-1,imw)+mask_s(h+1,imw)+mask_s(h,imw-1)==0
        im_in(h,imw) = -1;
        im_edge(h,imw)= -1;
    else
        if mask_s(h,imw)+mask_s(h-1,imw)+mask_s(h+1,imw)+mask_s(h,imw-1)==4
        im_out(h,imw) = -1;
        im_edge(h,imw)= -1;
        else
            im_out(h,imw) = -1;
            im_in(h,imw)= -1;
        end
    end
end

if mask_s(1,1)+mask_s(1,2)+mask_s(2,1)==0
    im_in(1,1) = -1;
    im_edge(1,1) = -1;
else
    if mask_s(1,1)+mask_s(1,2)+mask_s(2,1)==3
        im_out(1,1) = -1;
        im_edge(1,1) = -1;
    else im_in(1,1) = -1;
        im_out(1,1) = -1;
    end
end
if mask_s(imh,1)+mask_s(imh-1,1)+mask_s(imh,2)==0
    im_in(imh,1) = -1;
    im_edge(imh,1) = -1;
else
    if mask_s(imh,1)+mask_s(imh-1,1)+mask_s(imh,2)==3
        im_out(imh,1) = -1;
        im_edge(imh,1) = -1;
    else im_in(imh,1) = -1;
        im_out(imh,1) = -1;
    end
end
if mask_s(imh,imw)+mask_s(imh-1,imw)+mask_s(imh,imw-1)==0
    im_in(imh,imw) = -1;
    im_edge(imh,imw) = -1;
else
    if mask_s(imh,imw)+mask_s(imh-1,imw)+mask_s(imh,imw-1)==3
        im_out(imh,imw) = -1;
        im_edge(imh,imw) = -1;
    else im_in(imh,imw) = -1;
        im_out(imh,imw) = -1;
    end
end
if mask_s(1,imw)+mask_s(2,imw)+mask_s(1,imw-1)==0
    im_in(1,imw) = -1;
    im_edge(1,imw) = -1;
else
    if mask_s(1,imw)+mask_s(2,imw)+mask_s(1,imw-1)==3
        im_out(1,imw) = -1;
        im_edge(1,imw) = -1;
    else im_in(1,imw) = -1;
        im_out(1,imw) = -1;
    end
end




%%   blending(solve for V)
s = im;
maxV = max(im2var(:));
A = zeros(imh*(imw-1)+imw*(imh-1)+1,maxV);
b = zeros(imh*(imw-1)+imw*(imh-1)+1,1);
%%
e = 0;
for y = 1:imh
   for x = 1:imw-1
%Obj 1
e = e + 1;
A(e, im2var(y,x+1))=1; 
A(e, im2var(y,x))=-1; 
b(e) = s(y,x+1)-s(y,x); 
   end
end
%%
%Obj 2 
for x = 1:imw
   for y = 1:imh-1
e = e + 1;
A(e, im2var(y+1,x))=1; 
A(e, im2var(y,x))=-1; 
b(e) = s(y+1,x)-s(y,x);
   end
end
%% Obj 3
e = e + 1;
A(e, im2var(1,1))=1; 
b(e)=s(1,1); 

%%
v = A\b;
%%
new_img = reshape(v, [imh, imw, nb]);
imshow(new_img);
%%