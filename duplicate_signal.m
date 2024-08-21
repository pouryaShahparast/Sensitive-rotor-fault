function [signal_n,time_n] = duplicate_signal(orginal_signal,orginal_time,n,fs)
signal_n = zeros(n*size(orginal_signal,1),1);
time_n = zeros(n*size(orginal_time,1),1);
time_n(1) = 1/fs;

for i = 2:size(time_n,1)
    time_n(i) = time_n(i-1) + time_n(1); 
end


for i = 1:size(signal_n,1)
    if i <= size(orginal_signal,1)
        signal_n(i) = orginal_signal(i);
    else
        signal_n(i) = signal_n(i - size(orginal_signal,1));
    end
end


end

