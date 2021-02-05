function H = computeH(im1_pts,im2_pts)
% load('F1.mat');
% load('M1.mat');
% im1_pts = M1(1:4,:);
% im2_pts = F1(1:4,:);
L = size(im1_pts,1);
%%
B = -1*reshape(im2_pts',[2*L,1]);

X = zeros(2*L,8);
S1 = [1:2:2*L];
S2 = [2:2:2*L];
X(S1,1:2) = (-1)*im1_pts;
X(S2,4:5) = (-1)*im1_pts; 
X(S1,3) = -1;
X(S2,6) = -1;
X(S1,7) = bsxfun(@times,im1_pts(:,1),im2_pts(:,1)); %x1 x1'
X(S1,8) = bsxfun(@times,im1_pts(:,2),im2_pts(:,1));  % y1 x1'
X(S2,7) = bsxfun(@times,im1_pts(:,1),im2_pts(:,2)); %x1 y1'
X(S2,8) = bsxfun(@times,im1_pts(:,2),im2_pts(:,2));  % y1 y1'

%%

H = X\B;
H = reshape([H;1],[3,3])';
