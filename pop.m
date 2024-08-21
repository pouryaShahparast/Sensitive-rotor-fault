function [v] = pop(v,x)
n = size(v,1);
v(2:n) = v(1:n-1);
v(1) = x;
end

