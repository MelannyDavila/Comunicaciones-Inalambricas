%% Literal 1
clc, clear all, close all
totalPerdidas = [];
totalPerdidas2 = [];
%Frecuencia 500MHz
d=1:1e3;
perdidas = fs(d,500);
totalPerdidas = [totalPerdidas, perdidas];
%Frecuencia 2.4GHz
perdidas2 = fs(d,2400);
totalPerdidas2 = [totalPerdidas2, perdidas2];

semilogx(1:1e3, totalPerdidas, 1:1e3, totalPerdidas2)
title('Modelo de propagacion Free-Space')
legend('Perdidas a 500 MHz', 'Perdidas a 2.4 GHz')
xlabel('Distancia [m]'), ylabel('Perdidas [dB]')
grid on
