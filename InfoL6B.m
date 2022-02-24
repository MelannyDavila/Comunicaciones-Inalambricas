clc
clear all
close all
%Datos
n=1e5;%Numero de bits 
Eb_N0=0:10; %Vector de energia de bits
des=1/sqrt(2);
bits= randi([0 1],n,1);%bits transmitidos
k=6;%En dB
k=10^(6/10); %K en veces
sigma=1/sqrt(2);%Factor sigma
omega=1;%Factor omega

for i=1:length(Eb_N0)
% Escenario 1  
m=2;%Numero de bits por simbolos
M=2^m;%Numero de estados 4-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
InformacionModulada = modulador(bits,m);%bits modulados 4-QAM
InformacionCanal=rician(n,k,omega); %canal Rayleigh
InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
InformacionRuido=awgn(Producto,SNR1(i),'measured');%Ruido AWGN
InformacionEcualizada=InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
InformacionDemodulada=demodulador(InformacionEcualizada,m);%bits demodulados 4-QAM
[Bit_Er3,BER(i)]= biterr(bits,InformacionDemodulada);%BER 

% Escenario 2

InformacionModulada = modulador(bits,m);%bits modulados 4-QAM
m=4;%Numero de bits por simbolos
M=2^m;%Numero de estados 16-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
InformacionCanal=rician(n,k,omega); %canal Rician
histogram(abs(InformacionCanal))
InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
InformacionRuido=awgn(Producto,SNR1(i),'measured');%Ruido AWGN
InformacionEcualizada=InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
InformacionDemodulada=demodulador(InformacionEcualizada,m);%bits demodulados 4-QAM
[Bit_Er2,BER2(i)]= biterr(bits,InformacionDemodulada);%BER 
end  

m=2;%Numero de bits por simbolos
M=2^m;%Numero de estados 4-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
%Escenario 4
kfactor=10^(k/10);
BER3 = berfading(Eb_N0,'qam',4,1,kfactor);
m=4;%Numero de bits por simbolos
M=2^m;%Numero de estados 16-QAM
SNR=Eb_N0+10*log10(m);%Transformacion a SNR
BER4 = berfading(Eb_N0,'qam',16,1,kfactor);
figure
semilogy(Eb_N0,BER,'K:','Linewidth',1.5);
hold on
semilogy(Eb_N0,BER2,'-o');
hold on
semilogy(Eb_N0,BER3,'-+');
hold on 
semilogy(Eb_N0,BER4,'*-');
grid on
title('BER vs. Eb/No, Modulacion M-QAM')
xlabel('Eb/No')
ylabel('BER')
legend('Rician con ecualizacion 4-QAM','Rician con ecualizacion 16-QAM','Rician teorico 4-QAM','Rician teorico 16-QAM');