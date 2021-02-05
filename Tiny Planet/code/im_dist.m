function distance = im_dist(im_pt1,im_pt2,direction)
im_pt1 = im_pt1';
im_pt2 = im_pt2';
if direction=='y'
    dir = im_pt1(2,:)-im_pt2(2,:);
    distance = dir/abs(dir)*sqrt(sum((im_pt1-im_pt2).^2));  
else 
    dir = im_pt1(1,:)-im_pt2(1,:);
    distance = dir/abs(dir)*sqrt(sum((im_pt1-im_pt2).^2));  
end
