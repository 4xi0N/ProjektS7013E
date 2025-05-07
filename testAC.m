w = 3;

V1 = @(t) 1 + 0.5*sin(w*t);
V2 = @(t) 1 - 0.5*sin(w*t);

t = linspace(0,2*pi);

figure
hold on
plot(t,V1(t),t,V2(t),t,V1(t)-V2(t))
legend('V1','V2','V1-V2')