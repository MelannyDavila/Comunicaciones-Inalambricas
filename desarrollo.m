clc
clear all
close all
m=1; %BPSK
N = 10000;
informacion = randi([0 m-1],1, N*m)';
pe2=[]; %creacion de un vector para la
%probabilidad de error
Eb_No=0:10;
for i=0:length(Eb_No) %lazo for para variar el valor de Eb/No
    x=sqrt(10^(i/10)); %cambio de dB a veces el valor de EB/No
    pe1B=0.5 *erfc(x); %Calculo de la prob. de error
    pe2=[pe2 pe1B]; %asignacion de los valores obtenidos al vector pe
end
BERT = zeros(1,10);
SNR=Eb_No+10*log10(m);
for i=0:length(Eb_No)    
    informacionModulada = modulador(informacion, m);
    informacionRuido = awgn(informacionModulada, SNR(i), 'measured');
    %Receptor
    informacionDemodulada = demodulador(informacionRuido, m);
    [bitsErr, BER]= biterr( informacion,informacionDemodulada);
    BERT(SNR+1) = BER; 
end
%Simulada

semilogy(Eb_No,BERT,'-.','LineWidth',1.5)
%Teorica
hold on
semilogy(Eb_No,pe2','*-','LineWidth',1.5); %grafica de Eb/No vs. Prob. error
hold on 
%Con comando
berComando = berawgn(Eb_No, 'psk', 2, 'nondiff');
semilogy(Eb_No, berComando,'k+:', 'LineWidth',1.5)
title('BER vs. Eb/No para BPSK')
xlabel('BER')
ylabel('Eb/No[dB]')
legend('Simulada', 'Teorica formula', 'Teorica comando')
grid on %cuadricula