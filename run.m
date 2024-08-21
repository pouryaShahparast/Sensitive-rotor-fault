clc;
clear;
close all;

path = strings(6,1);
for i = 1:6
    path(i) = "ALL000" + i + ".CSV";
end

fs = 1000;
sigma = 20;
num_of_average = 5;
M = 0.03;

Rs = 39000;

f_Vm = NaN([sigma,1]);
f_Vg = NaN([sigma,1]);
f_Vm1 = NaN([sigma,1]);
f_Vg1 = NaN([sigma,1]);

down_Vm = NaN([num_of_average+1,1]);
down_Vg = NaN([num_of_average+1,1]);

tre = 0.2;
was_steady= 0;
is_steady = 0;

tre2 = 0.4;
previous_Vm = NaN;
previous_Vg = NaN;
previous_dVm = NaN;
previous_dVg = NaN;

[mixed_Vm,mixed_Vg,mixed_time,foult_75n_Vg,foult_75n_Vm,foult_75n_time,foult_3u_Vg,foult_3u_Vm,foult_3u_time,nofoult_75n_Vg,nofoult_75n_Vm,nofoult_75n_time,nofoult_3u_Vg,nofoult_3u_Vm,nofoult_3u_time] = mixed_signals();


[signal_Vm_lab, signal_Vg_lab, time_lab] = get_my_deta(path,3,fs);

signal_Vm = mixed_Vm;
signal_Vg = mixed_Vg;
signal_time = mixed_time;
Rm = 375;


%signal_Vm = signal_Vm_lab{1};
%signal_Vg = signal_Vg_lab{1};
%signal_time = time_lab{1};
%Rm = 330;

show_signal(signal_time,signal_Vm,figure("Name",'Vm'))
show_signal(signal_time,signal_Vg,figure("Name",'Vg'))

n = size(signal_Vg,1);

Rr = NaN([n,1]);

for i = 1:n
    %filtering
    f_Vm = pop(f_Vm,signal_Vm(i));
    f_Vm1 = pop(f_Vm1,sum(remove_NaNs(f_Vm))/size(remove_NaNs(f_Vm),1));

    f_Vg = pop(f_Vg,signal_Vg(i));
    f_Vg1 = pop(f_Vg1,sum(remove_NaNs(f_Vg))/size(remove_NaNs(f_Vg),1));

    if ~hasNaN(f_Vm1)
        %down sampling
        down_Vm = pop(down_Vm,sum(f_Vm1)/size(f_Vm1,1));
        down_Vg = pop(down_Vg,sum(f_Vg1)/size(f_Vg1,1));

        f_Vm1 = NaN([sigma,1]);
        f_Vg1 = NaN([sigma,1]);

        if abs(down_Vg(1) - down_Vg(2)) <= abs(down_Vg(1))*tre
            is_steady = 1;
        else
            is_steady = 0;
        end
        %calculating R
        if (is_steady == 0) && (was_steady == 1)
            Vm = sum(down_Vm(2:num_of_average+1))/num_of_average;
            Vg = sum(down_Vg(2:num_of_average+1))/num_of_average;

            if ~isnan(previous_Vg)
                dVm = abs(Vm - previous_Vm);
                dVg = abs(Vg - previous_Vg);
                
                if dVm <= M
                    Rr(i) = 10^6;
                else
                    if (abs(previous_dVm - dVm) <= abs(previous_dVm)*tre2) && (abs(previous_dVg - dVg) <= abs(previous_dVg)*tre2)
                        Rr(i) = Rm*(dVg/dVm)-(Rm+Rs/2);
                    else
                        Rr(i) = NaN;
                    end
                end

                previous_dVm = dVm;
                previous_dVg = dVg;

            else
                Rr(i) = NaN;
            end

            previous_Vm = Vm;
            previous_Vg = Vg;

        end

        was_steady = is_steady;

    end


end
r = remove_NaNs(Rr);

