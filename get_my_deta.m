function [signal, voltage, time] = get_my_deta(paths,repeats,fs)
    signal = cell(size(paths));
    voltage = cell(size(paths));
    time = cell(size(paths));
    
    unedited_s = cell(size(paths));
    unedited_v = cell(size(paths));
    unedited_t = cell(size(paths));
    
    for i = 1:size(paths,1)
        [unedited_s{i}, unedited_t{i}, unedited_v{i}, ~] = get_deta(paths(i),fs);
    end
    
    for i = 1:4
        [signal{i}, time{i}] = duplicate_signal(unedited_s{i},unedited_t{i},repeats,fs);
        [voltage{i}, ~] = duplicate_signal(unedited_v{i},unedited_t{i},repeats,fs);
    end
    for i = 5:6
        [signal{i}, time{i}] = change56(unedited_s{i},unedited_t{i},fs);
        [voltage{i}, ~] = change56(unedited_v{i},unedited_t{i},fs);
        [signal{i}, time{i}] = duplicate_signal(signal{i},time{i},repeats,fs);
        [voltage{i}, ~] = duplicate_signal(voltage{i},time{i},repeats,fs);
    end
end

