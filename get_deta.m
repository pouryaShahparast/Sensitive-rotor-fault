function [signal, signal_time, voltage, voltage_time] = get_deta(s,f)
    e = readtable(s,'Range','A20:B20');
    t_os = table2array(e(1,2));
    t_new = 1/f;
    m = t_new/t_os;
    signal_time_e_os = table2array(readtable(s,'Range','A27:A10026'));
    signal_os = table2array(readtable(s,'Range','B27:B10026'));
    
    voltage_time_e_os = table2array(readtable(s,'Range','C27:C10026'));
    voltage_os = table2array(readtable(s,'Range','D27:D10026'));
    signal_time_os = signal_time_e_os;
    for i = 1:10000
        signal_time_os(i) = signal_time_e_os(i) - signal_time_e_os(1); 
    end
    voltage_time_os = voltage_time_e_os;
    for i = 1:10000
        voltage_time_os(i) = voltage_time_e_os(i) - voltage_time_e_os(1); 
    end
    k = 10000/m;
    signal = zeros(k, 1);
    signal_time = zeros(k, 1);
    voltage = zeros(k, 1);
    voltage_time = zeros(k, 1);   
    for i = 1:10000/m
        signal(i) = signal_os(i * m);
        signal_time(i) = signal_time_os(i * m);
        voltage(i) = voltage_os(i * m);
        voltage_time(i) = voltage_time_os(i * m);
    end
end

