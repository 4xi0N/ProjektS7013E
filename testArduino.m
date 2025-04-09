clear s;
s = serialport('COM3',115200);
voltage_array = [];
while true
    voltage_data = str2double(readline(s));
    voltage = voltage_data * 3.3 / 4095;
    voltage_array = [voltage_array, voltage];
    
    % Create time vector assuming each sample is 0.1 seconds apart
    t = (0:length(voltage_array)-1) * 0.1; 
    
    plot(t, voltage_array, 'r-');
    xlabel('Time (seconds)');
    ylabel('Voltage (V)');
    drawnow; % Ensures the plot updates in real time
end
