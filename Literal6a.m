clc
clear all
close all
N=10000;
m=1; %numero de bits por simbolo
Eb_No=0;
SNR=Eb_No+10*log10(m);
%Generacion de bits
informacion = randi([0 m-1],1, N*m)';
%Modulacion
informacionModulada = modulador(informacion, m);
%Canal AWGN
informacionRuido = awgn(informacionModulada, SNR, 'measured');
%Demodulacion
informacionDemodulada = demodulador(informacionRuido, m);
[bitsErr, BER]= biterr( informacion,informacionDemodulada);
fprintf('La tasa de bit errado es: %.3f \n',BER)

