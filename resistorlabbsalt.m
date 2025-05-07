%% Simulera outputspänning för olika resistorvärden
distance = 0.03;    %Distance between plates in water
Area = 4e-5;      %Area of plates in water
Rwater = linspace(0.04,500)/Area*distance;  %0.04 Ohms*m is at saturated water (google)

% Bestämma enkelt samband mellan R och Salthalt
salinity = [1e-4,3e-4,1e-3,3e-3,1e-2,3e-2,.1,.3,1,3,5,10,20];
conductivity = 1e-6*[2.2,6.5,21.4,64,210,617,1990,5690,17600,48600,78300,140e3,226e3]*1e2;

Rwater = distance/Area*1./conductivity;

Index = Rwater < 5e3;       %In lab, we measured 5kOhm resistance in tap water

Rwater = Rwater(Index);
salinity = salinity(Index);





Rmin = Rwater(end);
R2 = 1e4;

R32 = logspace(1,4,4);      %Ratio R3/R2
%R32 = 1000;
%R3 = 1000;
Rbuffer = [0];
Vs = 1;

R4 = @(R32) Rmin*R32;

Rbridge = @(Rv,R2,R32) 1./(1./(Rv+R4(R32)) + 1./(R2*(1+R32)));

Vbridge = @(Rv,R2,R32,Rbuffer,Vs) Rbridge(Rv,R2,R32)/(Rbridge(Rv,R2,R32) + Rbuffer)*Vs;

Vo = @(Rv,R2,R32,Rbuffer,Vs) Vbridge(Rv,R2,R32,Rbuffer,Vs).*(R32*R2/(R32*R2+R2) - R4(R32)./(R4(R32)+Rv));
salinitylog = log(salinity);



%Plot figures
for j = 1:length(Rbuffer)
    figure
    hold on
    
    Legend = cell(length(R32),1);
    
    for i = 1:length(R32)
        subplot(2,1,1)
        hold on
        Vout = Vo(Rwater,R2,R32(i),Rbuffer(j),Vs);
        semilogx(salinitylog,Vout)                       %Plot voltage vs resistance
     
        subplot(2,1,2)
        hold on
        
        IArduino = Vs./(Rbuffer(j) + Rbridge(Rwater,R2,R32(i)));
        semilogx(salinity,IArduino)
    
        Legend{i} = strcat('R32 = ',num2str(R32(i)),', R4 = ',num2str(R4(R32(i))));
    end
    
    %Plot legends
    subplot(2,1,1)
    title('Output voltage vs Water Resistance')
    xlabel('Log[Salinity]')
    ylabel('Output Voltage [V]')
    legend(Legend)
    
    subplot(2,1,2)
    title('Current through Bridge')
    xlabel('Log [Salinity')
    ylabel('Current [A]')
    legend(Legend)

    sgtitle(strcat('Buffert Resistance = ',num2str(Rbuffer(j))))
end