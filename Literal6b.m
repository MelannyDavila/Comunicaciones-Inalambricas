clc
clear all
close all
N =100000;
Eb_No=0:10; %Vector de Eb/No
m=1; %Numero de bits por simbolos
BERT=[]; %Vector vacio para registrar BER
SNR=Eb_No+10*log10(m); %Transformacion a SNR
informacion = randi([0 1],1, N*m)'; %Datos aleatorios
for i=1:length(Eb_No)
    informacionModulada = modulador(informacion, m);
    informacionRuido = awgn(informacionModulada, SNR(i), 'measured');
    %Receptor
    informacionDemodulada = demodulador(informacionRuido, m);
    [bitsErr, BER]= biterr( informacion,informacionDemodulada);
    BERT(i) = BER; 
end
%Gráfica simulada
semilogy(Eb_No,BERT,'-.','LineWidth',1.5)
hold on

%Teorica probabilidad de error
Prob=[]; %Vector vacio
for i=0:length(Eb_No)-1 %lazo for para variar el valor de Eb/No
    x=sqrt(10^(i/10)); %cambio de dB a veces el valor de Eb/No
    pe1B=0.5 *erfc(x); %Calculo de la prob. de error
    Prob=[Prob pe1B]; %asignacion de los valores obtenidos prob. error
end
%Grafica teorica formula
semilogy(Eb_No,Prob','*-','LineWidth',1.5);
%Teorica con comando
berComando = berawgn(Eb_No, 'psk', 2, 'nondiff');
hold on
%Grafica teorica comando
semilogy(Eb_No, berComando,'k+:', 'LineWidth',1.5)
%Titulo
title('BER vs. Eb/No para BPSK')
%Nombre de ejes 
ylabel('BER')
xlabel('Eb/No[dB]')
%Leyendas
legend('Simulada', 'Teorica formula', 'Teorica comando')
grid on %cuadricula

