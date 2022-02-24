clc
clear all
close all
%Datos
n=1e5;%Numero de bits 
Eb_N0=0:10; %Vector de energia de bits
des=1/sqrt(2);
bits= randi([0 1],n,1);%bits transmitidos
sigma=1/sqrt(2);%Factor sigma
omega=1;%Factor omega

for i=1:length(Eb_N0)
% Escenario 1  
m=2;%Numero de bits por simbolos
M=2^m;%Numero de estados 4-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
InformacionModulada = modulador(bits,m);%bits modulados 4-QAM
InformacionCanal=canal_rayleigh(n,sigma); %canal Rayleigh
InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
InformacionRuido=awgn(Producto,SNR1(i),'measured');%Ruido AWGN
InformacionEcualizada=InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
InformacionDemodulada=demodulador(InformacionEcualizada,m);%bits demodulados 4-QAM
[Bit_Er3,BER(i)]= biterr(bits,InformacionDemodulada);%BER 

% Escenario 2
m=4;%Numero de bits por simbolos
M=2^m;%Numero de estados 16-QAM
InformacionModulada = modulador(bits,m);%bits modulados 4-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
InformacionCanal=canal_rayleigh(n,sigma); %canal Rayleigh
InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
InformacionRuido=awgn(Producto,SNR1(i),'measured');%Ruido AWGN
InformacionEcualizada=InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
InformacionDemodulada=demodulador(InformacionEcualizada,m);%bits demodulados 16-QAM
[Bit_Er2,BER2(i)]= biterr(bits,InformacionDemodulada);%BER 
end  

m=2;%Numero de bits por simbolos
M=2^m;%Numero de estados 4-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
%Escenario 4
BER3 = berfading(Eb_N0,'qam',4,1);
m=4;%Numero de bits por simbolos
M=2^m;%Numero de estados 16-QAM
SNR=Eb_N0+10*log10(m);%Transformacion a SNR
BER4 = berfading(Eb_N0,'qam',16,1);
figure(1)
semilogy(Eb_N0,BER,'->');
hold on
semilogy(Eb_N0,BER2,'-*');
hold on
semilogy(Eb_N0,BER3,'-+');
hold on 
semilogy(Eb_N0,BER4,'-<');
title('BER vs. Eb/No de Rayleigh con modulacion M-QAM')
xlabel('Eb/No')
ylabel('BER')
legend('Rayleigh con ecualizacion 4-QAM','Rayleigh con ecualizacion 16-QAM','Rayleigh teorico 4-QAM','Rayleigh teorico 16-QAM');
grid on
%%
clc
close all
clear all
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
InformacionCanal=canal_rician(n,k,omega); %canal Rician
InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
InformacionRuido=awgn(Producto,SNR1(i),'measured');%Ruido AWGN
InformacionEcualizada=InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
InformacionDemodulada=demodulador(InformacionEcualizada,m);%bits demodulados 4-QAM
[Bit_Er3,BER(i)]= biterr(bits,InformacionDemodulada);%BER 

% Escenario 2
m=4;%Numero de bits por simbolos
M=2^m;%Numero de estados 16-QAM
InformacionModulada = modulador(bits,m);%bits modulados 16-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
InformacionCanal=canal_rician(n,k,omega); %canal Rician
%histogram(abs(InformacionCanal))
InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
InformacionRuido=awgn(Producto,SNR1(i),'measured');%Ruido AWGN
InformacionEcualizada=InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
InformacionDemodulada=demodulador(InformacionEcualizada,m);%bits demodulados 16-QAM
[Bit_Er2,BER2(i)]= biterr(bits,InformacionDemodulada);%BER 
end  
kfactor=10^(k/10);
%Escenario 3
m=2;%Numero de bits por simbolos
M=2^m;%Numero de estados 4-QAM
SNR1=Eb_N0+10*log10(m);%Transformacion a SNR
BER3 = berfading(Eb_N0,'qam',4,1,kfactor);
%Escenario 4
m=4;%Numero de bits por simbolos
M=2^m;%Numero de estados 16-QAM
SNR=Eb_N0+10*log10(m);%Transformacion a SNR
BER4 = berfading(Eb_N0,'qam',16,1,kfactor);
figure(2)
semilogy(Eb_N0,BER,'->');
hold on
semilogy(Eb_N0,BER2,'-+');
hold on
semilogy(Eb_N0,BER3,'-.');
hold on 
semilogy(Eb_N0,BER4,'*-');
title('BER vs. Eb/No de Rician con modulacion M-QAM')
xlabel('Eb/No')
ylabel('BER')
grid on
legend('Rician con ecualizacion 4-QAM','Rician con ecualizacion 16-QAM','Rician teorico 4-QAM','Rician teorico 16-QAM');