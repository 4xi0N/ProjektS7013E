clear s;
s = serialport('COM3',115200);
voltage_array_salt = [];
voltage_array_temp = [];
while true
    line = readline(s);
    parts = str2double(split(strtrim(line), ','));
    voltage_salt = parts(1) * 3.3 / 4095;
    voltage_temp = parts(2) * 3.3 / 4095;
    voltage_array_salt = [voltage_array_salt, voltage_salt];
    voltage_array_temp = [voltage_array_temp, voltage_temp];

    % Create time vector assuming each sample is 0.1 seconds apart
    t = (0:length(voltage_array_salt)-1) * (1/10); 
    
    plot(t, voltage_array_salt, 'r-',t,voltage_array_temp,'b-');
    xlabel('Time (seconds)');
    ylabel('Voltage (V)');
    drawnow limitrate; % Ensures the plot updates in real time
end
