%% Literal 3 parte 1
clc, clear all, close all
totalPerdidas = zeros(3, 1e3);
distancia = 1:1e3;
for a=1:3 
    aux = ha(distancia,900,50,2,3,a);
    totalPerdidas(a,distancia) = aux; 
end
figure('Name','HA Parte 1')
semilogx(distancia, totalPerdidas(1,:), distancia, totalPerdidas(2,:),distancia, totalPerdidas(3,:))
legend('Perdidas a 900 MHz en area urbana', 'Perdidas a 900 MHz en area suburbana','Perdidas a 500 MHz en area abierta')
title('Modelo Hata')
xlabel('Distancia [km]'), ylabel('Perdidas [dB]')
grid on
%% Literal 3 parte 2
totalPerdidas = zeros(2, 1e3);
distancia=1:1e3;
%Frecuencia 180MHz
aux = ha(distancia,180,50,2,3,1);
totalPerdidas(1,distancia) = aux;
%Frecuencia 1.2GHz
aux = ha(distancia,1.2e3,50,2,3,1);
totalPerdidas(2,distancia) = aux;

figure('Name','HA: Figura 2')
semilogx(distancia, totalPerdidas(1,:), distancia, totalPerdidas(2,:))
title('Modelo Hata')
legend('Perdidas a 180 MHz en area urbana de cobertura grande', 'Perdidas a 2.3 GHz en area suburbana de cobertura grande')
xlabel('Distancia [km]'), ylabel('Perdidas [dB]')
grid on