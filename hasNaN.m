function [c] = hasNaN(v)
c = sum(isnan(v(:)));
end

