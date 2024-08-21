function [Vg,Vm,time] = get_ltspice_deta(fs,path_Vg,path_Vm)
t_n = 1/fs;
F = importdata(path_Vg);
Vg100k = F.data(:,2);
Tg100k = F.data(:,1);
F = importdata(path_Vm);
Vm100k = F.data(:,2);
Tm100k = F.data(:,1);

Vg = zeros(6*fs,1);
Vm = zeros(6*fs,1);
time = zeros(6*fs,1);

for i = 1:6*fs
    time(i) = i*t_n;
end

count_g = 1;
for i = 1:size(Tg100k,1)
    if (Tg100k(i) >= t_n*count_g )
        Vg(count_g) = Vg100k(i);
        count_g = count_g + 1;
    end
end

count_m = 1;
for i = 1:size(Tm100k,1)
    if (Tm100k(i) >= t_n*count_m )
        Vm(count_m) = Vm100k(i);
        count_m = count_m + 1;
    end
end

end

