%% Literal 2
clc, clear all, close all
totalPerdidas = zeros(4, 1e3);
k = 1;
distancia = 1:1e3;
for n=3:4
    aux = ln(distancia,500,n,1);
    totalPerdidas(k,distancia) = aux;
    k = k + 1;
    aux = ln(distancia,2400,n,1);
    totalPerdidas(n,distancia) = aux;
end
semilogx(distancia, totalPerdidas(1,:), distancia, totalPerdidas(2,:),distancia, totalPerdidas(3,:), distancia, totalPerdidas(4,:))
title('Modelo de propagacion Log-normal')
legend('Perdidas a 500 MHz con n=3', 'Perdidas a 500 MHz con n=4','Perdidas a 2.4 GHz con n=3', 'Perdidas a 2.4 GHz con n=4' )
xlabel('Distancia [m]'), ylabel('Perdidas [dB]')
grid on
