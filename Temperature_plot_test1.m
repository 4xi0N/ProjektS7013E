
t = [25; 70; 142; 219; 315; 404; 509; 609; 731; 838; 956; 1088; 1217; 1360; 1534];
T = 49:-1:50-length(t);
V = [0.8244, 0.8146, 0.7954, 0.7744, 0.7503, 0.7299, 0.7087, 0.6888, 0.6706, 0.6500, 0.6329, 0.6153, 0.5964, 0.5829, 0.5606];

figure;
plot(t, T, 'bo', 'DisplayName', 'Temp');
hold on;
xlabel('Time (s)');
ylabel('Temperature');
legend;
title('Temp vs time');
grid on;

figure;
plot(T, V, 'bo', 'DisplayName', 'Voltage');
hold on;
xlabel('Temperature');
ylabel('Voltage');
legend;
title('Voltage vs Temp');
grid on;

figure;
plot(V,T,'r-');
xlabel('Voltage [V]');
ylabel('Temperature [°C]');
title('Temperature as a function of voltage')
grid on

%%
parameters = polyfit(V,T,1);
A = parameters(1);
B = parameters(2);
model_function = @(z) A*z + B;
draw_model = model_function(V);
figure;
plot(V,T,'bo',V,draw_model,'r-');
legend('Data points','Model function',Location='northwest');
xlabel('Voltage [V]');
ylabel('Temperature [°C]')
title('Model function $T(V)=51.57V+6.258$',Interpreter='latex');
grid on
