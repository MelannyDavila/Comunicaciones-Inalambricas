%%Procedimiento
clc
clear
close all
%Datos
n=1e5;%Numero de bits 
m=1;%Numero de bits por simbolos
M=2^m;%Numero de estados
%m=log2(M);
Eb_N0=0:10; %Vector de energia de bits
SNR=Eb_N0+10*log10(m);%Transformacion a SNR
des=1/sqrt(2);
bits= randi([0 1],n*m,1);%bits transmitidos
kfactor=6;%En dB
k=10^(6/10); %K en veces
sigma=1/sqrt(2);%Factor sigma
omega=1;%Factor omega

for i=1:length(Eb_N0)
% Escenario 1   
InformacionModulada = modulador(bits,m);%bits modulados
InformacionRuido=awgn(InformacionModulada,SNR(i),'measured');%Colocamos Ruido
InformacionDemodulada=demodulador(InformacionRuido,m);%bits demodulados
[Bit_Er,BER(i)]= biterr(bits,InformacionDemodulada);%BER
BER;

%Escenario 2
InformacionCanal=canal_rayleigh(n,sigma); %canal Rayleigh
InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
InformacionRuido2=awgn(Producto,SNR(i),'measured');%Ruido AWGN
InformacionDemodulada2=demodulador(InformacionRuido2,m);%Informacion demodulada
[Bit_Er2,BER2(i)]= biterr(bits,InformacionDemodulada2);%BER
BER2;

%Escenario 3
Producto1=InformacionModulada.*InformacionRayleigh;
InformacionRuido3=awgn(Producto1,SNR(i),'measured');%Ruido AWGN
InformacionEcualizada=InformacionRuido3./InformacionRayleigh;%Compensar con ecualizador
InformacionDemodulada3=demodulador(InformacionEcualizada,m);%bits demodulados
[Bit_Er3,BER3(i)]= biterr(bits,InformacionDemodulada3);%BER
BER3;
end  

%Escenario 4
BER4 = berfading(Eb_N0,'psk',M,1);

figure
semilogy(Eb_N0,BER,':');
hold on
semilogy(Eb_N0,BER2,'-o');
hold on
semilogy(Eb_N0,BER3,'-+');
hold on 
semilogy(Eb_N0,BER4,'*-');
grid on
title('BER vs. Eb/No, Modulacion BPSK')
xlabel('Eb/No')
ylabel('BER')
legend('Canal AWGN', 'Sin. Rayleigh sin ecualizacion','Sim. Rayleigh con ecualizacion','Teorico Rayleigh');


