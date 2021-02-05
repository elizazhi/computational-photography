function bulge = bulgeFn(bulge_factor, size_factor, xx);
% x between 0 and 1
% bulge_factor between 0 and 1
% size_factor between 0 and 1

%m = 500*bulge_factor;
bulge = zeros(length(xx),1);
%for i = 1:500
if length(xx)>1
    %%
    A = 1/(bulge_factor^size_factor+(1-bulge_factor)^size_factor);
    bulge_ind = find(xx>bulge_factor);
    bulge_ind_i = find(xx<=bulge_factor);
    bulge(bulge_ind) = A*(xx(bulge_ind)-bulge_factor).^size_factor+A*bulge_factor^size_factor;
    bulge(bulge_ind_i) = -A*(-(xx(bulge_ind_i)-bulge_factor)).^size_factor+A*bulge_factor^size_factor;
    
else
    A = 1/(bulge_factor^size_factor+(1-bulge_factor)^size_factor);
    if xx>bulge_factor
    bulge = A*(xx-bulge_factor)^size_factor+A*bulge_factor^size_factor;
    else
    bulge = -A*(-(xx-bulge_factor))^size_factor+A*bulge_factor^size_factor;
    end
end
%end
%bulge = bulge-min(bulge);
%bulge = bulge/max(bulge);
    