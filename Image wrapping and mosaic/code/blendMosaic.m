%% labeling ---- 1
moving = im2double(imread('101-102(R).JPG'));
%fixed = im2double(imread('101-102(R).JPG'));
fixed = im2double(imread('WK-103-Ransac.JPG'));
cpselect(moving,fixed);

%%
%pt1--left; pt2--right
pt1 = mean(movingPoints);
pt2 = mean(fixedPoints);
%pt1 = movingPoints;
%pt2 = fixedPoints;
h_off = pt2(1)-pt1(1);
v_off = pt2(2)-pt1(2);

boundary_l = max(pt1(1),pt2(1));
boundary_r = max(size(moving,2)-pt1(1),size(fixed,2)-pt2(1));
boundary_u = max(pt1(2),pt2(2));
boundary_d = max(size(moving,1)-pt1(2),size(fixed,1)-pt2(2));

%%
im_new1 = zeros(ceil(boundary_u+boundary_d), ceil(boundary_r+boundary_l),3);
im_new1(1:size(fixed,1),1:size(fixed,2),:) = fixed;
im_new1 = imtranslate(im_new1,[-h_off, -v_off]);

%%
im_new2 = zeros(ceil(boundary_u+boundary_d), ceil(boundary_r+boundary_l),3);
im_new2(1:size(moving,1),1:size(moving,2),:) = moving;

%%

im_compose = zeros(ceil(boundary_u+boundary_d), ceil(boundary_r+boundary_l),3);
for jj = 1:size(im_compose,1)
for ii = 1:size(im_compose,2)
    if ii< size(im_compose,2)-size(fixed,2)+1 || jj <= -v_off || jj > -v_off+size(fixed,1)
    im_compose(jj,ii,:) = im_new2(jj,ii,:);
    else
        if ii>size(moving,2) || jj > size(moving,1)
            im_compose(jj,ii,:) = im_new1(jj,ii,:);
        else
            f1 = (ii-(size(im_new1,2)-size(fixed,2)))/(size(moving,2)+size(fixed,2)-size(im_compose,2));
            f2 = 1-f1;
            im_compose(jj,ii,:) = f2*im_new2(jj,ii,:)+f1*im_new1(jj,ii,:);
        end
    end
end
end
%%
imwrite(im_compose,'101-102-103(R).jpg');
%im_MaxGrad = choosePix(im_new1,im_new2);

%Mask = rgb2gray(im_MaxGrad)~=0;
%%
%im_final = im_MaxGrad.*repmat(Mask,[1,1,3])+im_compose.*repmat((1-Mask),[1,1,3]);



