function [changed_signal,changed_time] = change56(orginal_signal,orginal_time,fs)
changed_signal = zeros(size(orginal_signal,1) + fs/10,1);
changed_time = zeros(size(orginal_time,1) + fs/10,1);

changed_signal(1:2*fs/50) = orginal_signal(1:2*fs/50);
changed_signal(1 + 2*fs/50 : size(orginal_signal,1) + 2*fs/50) = orginal_signal(1 : size(orginal_signal,1));
changed_signal(1 + size(orginal_signal,1) + 2*fs/50 : size(changed_signal,1) - fs/50) = orginal_signal(size(orginal_signal,1) - 2*fs/50 + 1: size(orginal_signal,1));
changed_signal(1 + size(changed_signal,1) - fs/50 : size(changed_signal,1)) = orginal_signal(size(orginal_signal,1) - fs/50 + 1: size(orginal_signal,1));

changed_time(1) = 1/fs;
for i = 2:size(changed_time,1)
    changed_time(i) = changed_time(i-1) + changed_time(1); 
end



end

