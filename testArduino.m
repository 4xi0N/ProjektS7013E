clear s;
s = serialport('COM3',115200);
voltage_array = [];
while true
    voltage_data = str2double(readline(s));
    voltage = voltage_data*3.3/4095;
    voltage_array = [voltage_array,voltage];
    plot(1:length(voltage_array),voltage_array,'r-');
end

