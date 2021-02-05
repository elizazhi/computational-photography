function im_out = toy_reconstruct(im)
%im = im2double(imread('toy_problem.png')); 

[imh, imw, nb] = size(im); 
im2var = zeros(imh, imw); 
im2var(1:imh*imw) = 1:imh*imw; 

%%
s = im;
maxV = max(im2var(:));
A = sparse([], [], [],(imh*(imw-1)+imw*(imh-1)+1),maxV,2*(imh*(imw-1)+imw*(imh-1)+1));
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
im_out = reshape(v, [imh, imw, nb]);
%imshow(im_out);
