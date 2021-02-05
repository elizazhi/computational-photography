function meanIm1 = feather(meanIm);
%%
meanIm1 = meanIm;
mask1 = meanIm(:,:,1)==0;
mask = mask1;
[row,col] = find(meanIm(:,:,1)~=0);
row = unique(row);
col = unique(col);

for j = min(col):max(col)
    col_index = unique(find(meanIm(:,j,1)~=0));
    for i = min(col_index):min(col_index)+15
        mask(i,j) = 1;
    end
    for i =max(col_index)-15:max(col_index)
        mask(i,j)=1;
    end
end

for j = min(row):max(row)
    row_index = unique(find(meanIm(j,:,1)~=0));
    for i = min(row_index):min(row_index)+15
        mask(j,i) = 1;
    end
    for i =max(row_index)-15:max(row_index)
        mask(j,i)=1;
    end
end

%%
blurh = fspecial('gauss',25,50); 
maska = imfilter(double(mask),blurh,'replicate');
maskb = imfilter((1-mask),blurh,'replicate');
meanIm1= meanIm1.*repmat(maskb,[1,1,3]);

%%
imshow(meanIm1);