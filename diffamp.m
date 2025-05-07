%Differential Amplifier
%Choose R1,R2. This will give values for R3,R4 and amplification


R1 = 100;
R2 = 22000;

R3 = R1;
R4 = R2;

Acm = R4/(R3+R4)*(1+R2/R1) - R2/R1

Ad = 0.5*(R4/(R3+R4)*(1+R2/R1) + R2/R1)