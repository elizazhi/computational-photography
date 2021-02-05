function grad = gradientMax(s1, s2, t1, t2)
if abs(s1-s2) < abs(t1-t2)
    grad = t1-t2;
else
    grad = s1 - s2;
end
end