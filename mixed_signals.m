function [mixed_Vm,mixed_Vg,mixed_time,foult_75n_Vg,foult_75n_Vm,foult_75n_time,foult_3u_Vg,foult_3u_Vm,foult_3u_time,nofoult_75n_Vg,nofoult_75n_Vm,nofoult_75n_time,nofoult_3u_Vg,nofoult_3u_Vm,nofoult_3u_time] = mixed_signals()
[foult_75n_Vg,foult_75n_Vm,foult_75n_time] = get_ltspice_deta(1000,"foult_75n_Vg","foult_75n_Vm");
[foult_3u_Vg,foult_3u_Vm,foult_3u_time] = get_ltspice_deta(1000,"foult_3u_Vg","foult_3u_Vm");
[nofoult_75n_Vg,nofoult_75n_Vm,nofoult_75n_time] = get_ltspice_deta(1000,"nofoult_75n_Vg","nofoult_75n_Vm");
[nofoult_3u_Vg,nofoult_3u_Vm,nofoult_3u_time] = get_ltspice_deta(1000,"nofoult_3u_Vg","nofoult_3u_Vm");

n = 21000;

mixed_Vm = zeros(n,1);
mixed_Vg = zeros(n,1);
mixed_time = zeros(n,1);

for i = 1:n
    mixed_time(i) = i*0.001;
end

mixed_Vg(1:5500) = nofoult_75n_Vg(1:5500);
mixed_Vg(5501:10500) = foult_75n_Vg(501:5500);
mixed_Vg(10501:15500) = nofoult_3u_Vg(501:5500);
mixed_Vg(15501:21000) = foult_3u_Vg(501:6000);

mixed_Vm(1:5500) = nofoult_75n_Vm(1:5500);
mixed_Vm(5501:10500) = foult_75n_Vm(501:5500);
mixed_Vm(10501:15500) = nofoult_3u_Vm(501:5500);
mixed_Vm(15501:21000) = foult_3u_Vm(501:6000);

end

