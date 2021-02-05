function A = computeAffine(tri1_pts,tri2_pts)
% %% demo input (using first triangle)
% tri1_pts = zeros(3,2);
% tri2_pts = zeros(3,2);
% for i=1:3
% tri1_pts(i,:) = im1_pts(tri(1,i),:);
% tri2_pts(i,:) = im_pts(tri(1,i),:);
% end
%%
X = zeros(6,6);
X(1:3,1:2) = tri1_pts;
X(4:6,4:5) = tri1_pts;
X(1:3,3) = 1;
X(4:6,6) = 1;

B = reshape(tri2_pts,[6,1]);

A = X\B;

end
