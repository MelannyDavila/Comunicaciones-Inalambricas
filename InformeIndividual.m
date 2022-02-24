%Datos
n=1e5;%Numero de bits 
m=1;%Numero de bits por simbolos
M=2^m;%Numero de estados
%m=log2(M);
Eb_N0=0:10; %Vector de energia de bits
SNR=Eb_N0+10*log10(m);%Transformacion a SNR
des=1/sqrt(2);
bits= randi([0 1],n*m,1);%bits transmitidos
sigma=1/sqrt(2);%Factor sigma
omega=1;%Factor omega
k=6;%En dB
omega=1;%Factor omega
for i=1:length(Eb_N0)
% Escenario 1 Rayleigh
InformacionModulada = modulador(bits,m);%bits modulados
InformacionRuido=awgn(InformacionModulada,SNR(i),'measured');%Colocamos Ruido
InformacionDemodulada=demodulador(InformacionRuido,m);%bits demodulados
[Bit_Er,BER(i)]= biterr(bits,InformacionDemodulada);%BER

end
%Escenario 4 Rayleigh
BER2 = berfading(Eb_N0,'psk',M,1);
%Escenario 4 Rician
kfactor=10^(k/10);
BER3 = berfading(Eb_N0,'psk',M,1,kfactor);
figure
semilogy(Eb_N0,BER,':');
hold on
semilogy(Eb_N0,BER2,'-o');
hold on
semilogy(Eb_N0,BER3,'*-');
grid on
title('BER vs. Eb/No con BPSK para AWGN, Rayleigh y Rician')
xlabel('Eb/No')
ylabel('BER')
legend('Canal AWGN','Teorico Rayleigh','Teorico Rician');
