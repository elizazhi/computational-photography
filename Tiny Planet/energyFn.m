function G=energyFn(im);
   G=zeros(size(im,1),size(im,2));
   for ii=1:size(im,3)
   G=G+(filter2([.5 1 .5; 1 -6 1; .5 1 .5],im(:,:,ii))).^2;
   end
   ave = mean(G(2:size(G,1)-1,2:size(G,2)-1)');
   factor = max(ave);
   ave = (ave/factor);
   ave = smooth(ave,'loess')';
   % performance
   ave_map =  repmat(ave,size(G,2)-2,1);
   ave_map =  ave_map';
   %ave_map = [ave_map(1,:);ave_map;ave_map(end,:)];
   G(2:size(G,1)-1,2:size(G,2)-1) = G(2:size(G,1)-1,2:size(G,2)-1).*ave_map;
end
