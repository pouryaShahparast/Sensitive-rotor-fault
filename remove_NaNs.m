function [v] = remove_NaNs(s)
v = s(~isnan(s));
end

