function im_planet = morphToGlobe(im, size_factor, blend_factor,bulge_factor)
%factor all between 0 and 1;
%size factor 0.4 best

%im = im2double(imread('IMG_1399.jpg'));
%im = imresize(im, 0.3);

width = size(im, 2);
height = size(im, 1);
r = height;

%% on all three channels
%factor = 0.4; % between 0 and 1

Cor_out = zeros(2*r-1, 2*r-1, 3);
for col = 1:2*r-1
    for row = 1:2*r-1
        x = col-r;
        y = r-row;
        [theta,rho] = cart2pol(x,y);
        % inside the circle
       
       % (-,-) & (+,-) (theta will be negative)
     if rho < height
      if theta <= blend_factor/(1-blend_factor)*2*pi && theta >= 0
              COL1 = width - theta/(2*pi) * (1-blend_factor)* width;
              COL2 = COL1-(1-blend_factor)*width;
              %ROW = height - height^(1-size_factor)*(rho^size_factor);
              bulge = bulgeFn(bulge_factor, size_factor, rho/height);
              ROW = height - height* bulge;
              COL1_f = COL1 - floor(COL1);
              ROW_f = ROW - floor(ROW);
        
              COL1_low = floor(COL1);
              COL1_high = ceil(COL1);
              ROW_low = floor(ROW);
              ROW_high = ceil(ROW);
              
              COL2_f = COL2 - floor(COL2);
        
              COL2_low = floor(COL2);
              COL2_high = ceil(COL2);
              
              if ROW_low == 0
                 ROW_low = ROW_low+1;
              end
              if COL1_low == 0
                  COL1_low = COL1_low +1;
              end
              if COL2_low == 0
                  COL2_low = COL2_low +1;
              end
              Cor_end1 = (1-COL1_f)*(1-ROW_f)*im(ROW_low, COL1_low,1)+COL1_f*(1-ROW_f)*im(ROW_low, COL1_high,1)+(1-COL1_f)*ROW_f*im(ROW_high, COL1_low,1)+COL1_f*ROW_f*im(ROW_high, COL1_high,1);
              Cor_end2 = (1-COL1_f)*(1-ROW_f)*im(ROW_low, COL1_low,2)+COL1_f*(1-ROW_f)*im(ROW_low, COL1_high,2)+(1-COL1_f)*ROW_f*im(ROW_high, COL1_low,2)+COL1_f*ROW_f*im(ROW_high, COL1_high,2);
              Cor_end3 = (1-COL1_f)*(1-ROW_f)*im(ROW_low, COL1_low,3)+COL1_f*(1-ROW_f)*im(ROW_low, COL1_high,3)+(1-COL1_f)*ROW_f*im(ROW_high, COL1_low,3)+COL1_f*ROW_f*im(ROW_high, COL1_high,3);
              
              Cor_begin1 = (1-COL2_f)*(1-ROW_f)*im(ROW_low, COL2_low,1)+COL2_f*(1-ROW_f)*im(ROW_low, COL2_high,1)+(1-COL2_f)*ROW_f*im(ROW_high, COL2_low,1)+COL2_f*ROW_f*im(ROW_high, COL2_high,1);
              Cor_begin2 = (1-COL2_f)*(1-ROW_f)*im(ROW_low, COL2_low,2)+COL2_f*(1-ROW_f)*im(ROW_low, COL2_high,2)+(1-COL2_f)*ROW_f*im(ROW_high, COL2_low,2)+COL2_f*ROW_f*im(ROW_high, COL2_high,2);
              Cor_begin3 = (1-COL2_f)*(1-ROW_f)*im(ROW_low, COL2_low,3)+COL2_f*(1-ROW_f)*im(ROW_low, COL2_high,3)+(1-COL2_f)*ROW_f*im(ROW_high, COL2_low,3)+COL2_f*ROW_f*im(ROW_high, COL2_high,3);
              
              Cor_out(row, col, 1) = theta/(blend_factor/(1-blend_factor)*2*pi)*Cor_end1+(1-theta/(blend_factor/(1-blend_factor)*2*pi))*Cor_begin1;
              Cor_out(row, col, 2) = theta/(blend_factor/(1-blend_factor)*2*pi)*Cor_end2+(1-theta/(blend_factor/(1-blend_factor)*2*pi))*Cor_begin2;
              Cor_out(row, col, 3) = theta/(blend_factor/(1-blend_factor)*2*pi)*Cor_end3+(1-theta/(blend_factor/(1-blend_factor)*2*pi))*Cor_begin3;
              
%       else   
%       if row > r      
%         COL = width - (2*pi+theta)/(2*pi) * (1-blend_factor)*width;
%         %ROW = height - height^(1-size_factor)*(rho^size_factor);
%         bulge = bulgeFn(bulge_factor, size_factor, rho/height);
%         ROW = height - height* bulge;
%        else
%           % if rho < height
%               COL = width - theta/(2*pi) * (1-blend_factor)*width;
%              % ROW = height - height^(1-size_factor)*(rho^size_factor);
%               bulge = bulgeFn(bulge_factor, size_factor, rho/height);
%               ROW = height - height* bulge;
%            end   
%               COL_f = COL - floor(COL);
%               ROW_f = ROW - floor(ROW);
%         
%               COL_low = floor(COL);
%               COL_high = ceil(COL);
%               ROW_low = floor(ROW);
%               ROW_high = ceil(ROW);
%               
%               if ROW_low == 0
%                  ROW_low = ROW_low+1;
%               end
%               if COL_low == 0
%                   COL_low = COL_low +1;
%               end
%               Cor_out(row, col, 1) = (1-COL_f)*(1-ROW_f)*im(ROW_low, COL_low,1)+COL_f*(1-ROW_f)*im(ROW_low, COL_high,1)+(1-COL_f)*ROW_f*im(ROW_high, COL_low,1)+COL_f*ROW_f*im(ROW_high, COL_high,1);
%               Cor_out(row, col, 2) = (1-COL_f)*(1-ROW_f)*im(ROW_low, COL_low,2)+COL_f*(1-ROW_f)*im(ROW_low, COL_high,2)+(1-COL_f)*ROW_f*im(ROW_high, COL_low,2)+COL_f*ROW_f*im(ROW_high, COL_high,2);
%               Cor_out(row, col, 3) = (1-COL_f)*(1-ROW_f)*im(ROW_low, COL_low,3)+COL_f*(1-ROW_f)*im(ROW_low, COL_high,3)+(1-COL_f)*ROW_f*im(ROW_high, COL_low,3)+COL_f*ROW_f*im(ROW_high, COL_high,3);
      end
     end
    end
end
im_planet = Cor_out(ceil(height*(sqrt(2)-1)):2*height-1-ceil(height*(sqrt(2)-1)),ceil(height*(sqrt(2)-1)):2*height-1-ceil(height*(sqrt(2)-1)),:);
end
        
        