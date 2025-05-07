R = linspace(30,5e3);   %Use theoretical values for margin

%Bridge resistor values
R2b = 100;
R3b = 10e3;
R4b = 3.3e3;

Vs = 1;     %Amplitude of sinusoidal input signal

V1 = Vs*R4b./(R4b+R);
V2 = Vs*R3b/(R3b+R2b);

Vout = Vs*(R3b/(R3b+R2b) - R./(R4b+R));

figure
plot(R,V1,R,V2*ones(size(R)))
legend('V1 = Voltage from Salt','V2 = Voltage from resistors')

%Computations on instrumentation amplifier - we could see clipping at about
%5.5 V. Keep below 5 V for margin
R1 = 10e3;
R2 = 1e3;
Rg = 5e3;
R3 = 1.33e3;

%Amplitude at buffer op-amps:
Va = V2 + (V1-V2)*R1/Rg;
Vb = V1 - (V1-V2)*R1/Rg;

%Output voltage from instrumentation amplifier:
Vo = (V1-V2)*(1+R1/Rg)*R3/R2;

figure
subplot(2,1,1)
plot(R,Va,R,Vb)
legend('Output voltage buffer op-amp V2', 'Output voltage buffer op-amp V1')

subplot(2,1,2)
plot(R,Vo)
legend('Output voltage instrumentation amplifier')

gain = (1+R1/Rg)*R3/R2;

