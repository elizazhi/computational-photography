function [p] = feat_desc(im, y, x);
%%
%im = rgb2gray(im);
n = length(y);
p = zeros(64,n);
for i = 1:n
    P = im(y(i)-19:y(i)+20,x(i)-19:x(i)+20);
    P = imgaussfilt(P,'FilterSize',[5,5]);
    P=P(1:5:end,1:5:end);
    p(:,i) = reshape(P,[64,1]);
    meanP = mean(p(:,i));
    stdP = std(p(:,i));
    p(:,i) = (p(:,i)-meanP)/stdP;
end
    
