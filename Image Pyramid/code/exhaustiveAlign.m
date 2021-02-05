function [C1prime, r01, c01] = exhaustiveAlign(C1, C0,range, crop_lower, crop_upper)
% 0 < crop_lower < crop_upper < 1
sizeC0 = size(C0);
sizeC1 = size(C1);
C0crop = C0(ceil(crop_lower*sizeC0(1)):floor(crop_upper*sizeC0(1)),ceil(crop_lower*sizeC0(2)):floor(crop_upper*sizeC0(2)));
cor = zeros(range,range);
% Aligning B and G channel
for n1 = -range:range
    C1_1 = circshift(C1,n1,1);
     for n2 = -range:range
         C1_2 = circshift(C1_1,n2,2);
         C1crop = C1_2(ceil(crop_lower*sizeC1(1)):floor(crop_upper*sizeC1(1)),ceil(crop_lower*sizeC1(2)):floor(crop_upper*sizeC1(2)));
         cor(n1+range+1, n2+range+1) = dot(C0crop(:),C1crop(:))/norm(C0crop(:))/norm(C1crop(:));
     end
end
[r01,c01] = find(cor==max(max(cor)));
C1prime = circshift(circshift(C1, r01-range-1, 1), c01-range-1,2);
end