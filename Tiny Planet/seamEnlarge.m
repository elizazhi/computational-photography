function im=seamEnlarge(im,k)
%% illustrative example of Seam carving for content aware image resizing
%
%
% usage: carvedimg=seamcarving(im,k)
%
% k is how many vertical seams to remove.
% im is the image.
%
% example:
%   img=imread('peppers.png')
%   carvedimg=seamcarving(img,50)
%   image([carvedimg img]);
%   axis equal;
%
% Author: Aslak Grinsted 2007...
% Based on ideas from Avidan & Shamir:
% http://video.google.com/videoplay?docid=-6221880321193117495
% Note i havent read their paper and they have probably lots of smart tricks
% for optimizations.
%
%%
im = imread('IMG_0963.jpg');
im = imresize(im,0.3);
im=im2double(im);
k = round((sqrt(2)-1)*size(im,1));
im_out = zeros(k+size(im,1),size(im,2),3);
im_out(1:size(im,1),:,:) = im;
%%
for jj=1:k
    G=energyFn(im);
    %find shortest path in G
    Pot=G;
    for ii=2:size(Pot,2)
        pp=Pot(:,ii-1);
        ix=pp(1:end-1)<pp(2:end); 
        pp([false;ix])=pp(ix);
        ix=pp(2:end)<pp(1:end-1);
        pp(ix)=pp([false;ix]);
        Pot(:,ii)=Pot(:,ii)+pp;
    end
        
    %Walk down hill
    pix=zeros(size(G,2),1);
    [mn,pix(end)]=min(Pot(:,end));
    pp=find(Pot(:,end)==mn);
    pix(end)=pp(ceil(rand*length(pp)));
    
    im(pix(end),end,:)=nan;
    for ii=size(G,2)-1:-1:1
        %[mn,gg]=min(Pot(ii,pix+(-1:1)));
        [mn,gg]=min(Pot(max(pix(ii+1)-1,1):min(pix(ii+1)+1,end),ii));
        pix(ii)=gg+pix(ii+1)-1-(pix(ii+1)>1);
        im(pix(ii),ii,:)=bitand(ii,1);
%        G(ii,pix(ii))=1;
    end

    %add seam from im & G:
    for ii=2:size(im,2)
%        G(ii,pix(ii):end-1)=G(ii,pix(ii)+1:end);
          im(pix(ii):end-1,ii,:)=im(pix(ii)+1,ii:end,:);
%         im(pix(ii):end,ii,:)=(im(ii,pix(ii)+1:end,:)+im(ii,pix(ii)-1:end-2,:))/2;
%         im(ii,pix(ii):end-1,:)=(im(ii,pix(ii)+1:end,:)+im(ii,pix(ii)-1:end-2,:))/2;
    end
    im(end,:,:)=[];
%    G(:,end)=[];

end   
end
