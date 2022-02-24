clc
clear all
close all
f=900; %frecuencia de trabajo
d=1:1e3; %vector distancia
P_LS=fs(d,f); %perdidas free space
P_LN=ln(d,f,4,1);%perdidas log-normal
figure
semilogx(d,P_LS,d,P_LN);%grafica realizada
%nombres de los ojes
xlabel('Distancia [m]'), ylabel('Perdidas [dB]')
%leyendas de las graficas
legend('Modelo Free-Space', 'Modelo Log-Normal')
%titulo
title('Modelos de propagación en 900[MHz]')
%grilla activada
grid on



