clc
clear all
close all

perdidas = zeros(1,200e6); 
d=100; %distancia
for f=1:200e6 %frecuencia
    aux = fs(d, f);
    perdidas(f) = aux;
end
semilogx(f, perdidas)
title('Pérdidas vs. frecuencia')
xlabel('Frecuencia [Hz]'), ylabel('Perdidas [dB]')
grid on
