%function im_blend = poissonBlend(im_s, mask_s, im_background);
%im_out = toy_reconstruct(im)
load('im_s.mat');
load('mask_s.mat');
load('im_background.mat');

row_upper = find(any(mask_s==1, 2),1)-1;
row_lower = find(any(mask_s==1, 2),1,'last')+1;
col_left = find(any(mask_s==1, 1),1)-1;
col_right = find(any(mask_s==1, 1),1,'last')+1;

mask = mask_s(row_upper:row_lower,col_left:col_right);
im = im_s(row_upper:row_lower,col_left:col_right,1);
im_b = im_background(row_upper:row_lower,col_left:col_right,1);
[imh, imw, nb] = size(im); 
im2var = zeros(imh, imw); 
im2var(1:imh*imw) = 1:imh*imw; 
%% divide into 3 groups
im_in = im2var;
im_out = im2var;
im_edge = im2var;

for w = 2:imw-1
    for h = 2:imh-1
    if mask(h,w)+mask(h+1,w)+mask(h,w+1)==0
        im_in(h,w) = -1;
        im_edge(h,w)= -1;
    else
        if mask(h,w)+mask(h+1,w)+mask(h,w+1)==3
        im_out(h,w) = -1;
        im_edge(h,w)= -1;
        else
            if mask(h, w)==1
                im_out(h,w) = -1;
                im_in(h,w)= -1;
            else 
                im_edge(h,w) = -1;
                im_in(h,w)= -1;
            end
        end
    end
    end
end
%% edge cases
for w = 1:imw-1
    if mask(1,w)+mask(1,w+1)+mask(2,w)==0
        im_in(1,w) = -1;
        im_edge(1,w)= -1;
    else
        if mask(1,w)+mask(1,w+1)+mask(2,w)==3
        im_out(1,w) = -1;
        im_edge(1,w)= -1;
        else
            im_out(1,w) = -1;
            im_in(1,w)= -1;
        end
    end
end
for w = 1:imw-1
    if mask(imh,w)+mask(imh,w+1)==0
        im_in(imh,w) = -1;
        im_edge(imh,w)= -1;
    else
        if mask(imh,w)+mask(imh,w+1)==2
        im_out(imh,w) = -1;
        im_edge(imh,w)= -1;
        else
            im_out(imh,w) = -1;
            im_in(imh,w)= -1;
        end
    end
end
for h = 2:imh-1
    if mask(h,1)+mask(h+1,1)+mask(h,2)==0
        im_in(h,1) = -1;
        im_edge(h,1)= -1;
    else
        if mask(h,1)+mask(h+1,1)+mask(h,2)==3
        im_out(h,1) = -1;
        im_edge(h,1)= -1;
        else
            im_out(h,1) = -1;
            im_in(h,1)= -1;
        end
    end
end
for h = 1:imh-1
    if mask(h,imw)+mask(h+1,imw)==0
        im_in(h,imw) = -1;
        im_edge(h,imw)= -1;
    else
        if mask(h,imw)+mask(h+1,imw)==2
        im_out(h,imw) = -1;
        im_edge(h,imw)= -1;
        else
            im_out(h,imw) = -1;
            im_in(h,imw)= -1;
        end
    end
end

if mask(imh,imw)==0
    im_in(imh,imw) = -1;
    im_edge(imh,imw) = -1;
else
    im_out(imh,imw) = -1;
    im_edge(imh,imw) = -1;
end
%%   blending(solve for V)
% N_in = im_in~=-1;
% N = sum(N_in(:));
% A = sparse([], [], [], M, N, nzmax);

s = im;
maxV = max(im2var(:));
A = zeros(imh*(imw-1)+imw*(imh-1)+1,maxV);
b = zeros(imh*(imw-1)+imw*(imh-1)+1,1);
%%
e = 0;
for y = 1:imh
   for x = 1:imw-1
       if sum(any(im_in==im2var(y,x)))==1
%Obj 1 for im_in
e = e + 1;
A(e, im2var(y,x+1))=1; 
A(e, im2var(y,x))=-1; 
b(e) = s(y,x+1)-s(y,x);
       else
           if sum(any(im_edge==im2var(y,x)))==1
               %Obj 1 for im_edge
            e = e + 1; 
            A(e, im2var(y,x))=-1; 
            b(e) = s(y,x+1)-s(y,x);
           end
       end
   end
end
%%
%Obj 2 
for x = 1:imw
   for y = 1:imh-1
        if sum(any(im_in==im2var(y,x)))==1
e = e + 1;
A(e, im2var(y+1,x))=1; 
A(e, im2var(y,x))=-1; 
b(e) = s(y+1,x)-s(y,x);
       else
           if sum(any(im_edge==im2var(y,x)))==1
               %Obj 2 for im_edge
            e = e + 1; 
A(e, im2var(y,x))=-1; 
b(e) = s(y+1,x)-s(y,x);
           end
        end
   end
end
%% Obj 3
im_inS = im_in(im_in~=-1);
e = e + 1;
A(e, min(im_inS(:)))=1; 
b(e)=s(im2var==min(im_inS(:))); 

%% Obj 4
im_edgeS = im_edge(im_edge~=-1);
e = e + 1;
A(e, min(im_edgeS(:)))=1; 
b(e)=im_b(im2var==min(im_edgeS(:))); 

%% Obj 5
for x = 1:imw
   for y = 1:imh
                %Obj 1 for im_out
            e = e + 1; 
            A(e, im2var(y,x))=1; 
            b(e) = im_b(y,x);
   end
end
%%
v = A\b;
%%
new_img = reshape(v, [imh, imw, nb]);
imshow(new_img);
%%