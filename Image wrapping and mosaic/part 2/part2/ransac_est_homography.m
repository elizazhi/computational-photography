function [H,inlier_ind] = ransac_est_homography(y1, x1, y2, x2, thresh);
%%
% y1 = im_pt1(:,2);
% x1 = im_pt1(:,1);
% y2 = im_pt2(:,2);
% x2 = im_pt2(:,1);
%%
goOn = 1;

while goOn ==1
rand_idx = randi([1 length(y1)],1,4);
im_pt1 = [x1,y1];
im_pt2 = [x2,y2];
imp1 =im_pt1(rand_idx,:);
imp2 =im_pt2(rand_idx,:);
 %%
 %addpath('../');
 H_try = computeH(imp1,imp2);
 pt1 = [im_pt1,ones(length(y1),1)];
 pt1_prime = H_try*pt1';
 pt1_prime = bsxfun(@rdivide, pt1_prime, pt1_prime(3,:));
 im_pt1_prime = pt1_prime([1,2],:)';
 %%
 dist = sqrt(sum((im_pt1_prime-im_pt2).^2'))';
 vote = dist<thresh;
 vote_count = sum(vote);
 if vote_count < 0.5*length(y1)
     goOn = 1;
 else
     goOn = 0;
     H = H_try;
     inlier_ind = find(vote ==1);
 end
end
