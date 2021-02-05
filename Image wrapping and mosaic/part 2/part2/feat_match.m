function [m] = feat_match(p1,p2);
%%
m = zeros(length(p1),1);
n2 = dist2(p1',p2');
for i = 1:size(n2,1)
    % nearest
    d1 = min(n2(i,:));
    ind1 = find(n2(i,:)==d1);
    n2(i,ind1) = max(n2(i,:));
    % second nearest
    d2 = min(n2(i,:));
 %   ind2 = find(n2(i,:)==d2);
    if d1<0.26*d2   % threshold is 0.3, consulting the papaer
        m(i) = ind1;
    else
        m(i) = -1;
    end
end