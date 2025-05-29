clear s;
%load("SurfaceModel.mat");
load("ExpmodelY.mat");
%Model = @(Vs,Vt) a(1) + a(2)*Vs + a(3)*Vt + a(4)*Vs.*Vt + a(5)*Vs.^2 + a(6)*Vt.^2;
Model = @(Vs,Vt) param(1)*exp(param(2)*V2R(Vs) + param(3)*Vt) + param(4);
s = serialport('COM3',115200); % read data
voltage_array_salt = [];       % set up empty arrays
voltage_array_temp = [];
while true                     % run until user termination
    line = readline(s);        % read every new line in s
    parts = str2double(split(strtrim(line), ','));              % two parts, two voltages
    voltage_salt = parts(1) * 3.3 / 4095;                       % correct the values
    voltage_temp = parts(2) * 3.3 / 4095;
    voltage_array_salt = [voltage_array_salt, voltage_salt];    % voltage level
    voltage_array_temp = [voltage_array_temp, voltage_temp];    % used for plotting and saving

    % Create time vector assuming each sample is 0.1 seconds apart
    t = (0:length(voltage_array_salt)-1) * (1/10);              %keep track of time
    
    plot(t, voltage_array_salt, 'r-',t,voltage_array_temp,'b-');
    %legend('Resistivity voltage','Temperature voltage','Location','northwest')
    xlabel('Time (seconds)');
    ylabel('Voltage (V)');
    grid on
    drawnow limitrate; % Ensures the plot updates in real time
    
    
    disp(Model(voltage_array_salt(end),voltage_array_temp(end)))

end