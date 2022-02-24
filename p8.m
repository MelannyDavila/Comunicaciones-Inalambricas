clc
clear all
close all
format long
N = 64;%Numero de subportadoras
m = 2;%Numero de bits por simbolo
M=2^m;%Numero de estados
EbN0_dB = 0:9;
SNR = EbN0_dB + 10.*log10(m);
L = N * m; %Longitud del tren de bits
PC = N/4;%Longitud prefijo ciclico
Ntrials = 1000;
informacion = randi([0 1], 1, L); %tren de bits
for i = 1:length(EbN0_dB)
    for k = 1:Ntrials
        InformacionModulada = modulador(informacion, m); %Modulacion
        InformacionIFFT = ifft(InformacionModulada); %Uso IFFT
        InformacionPc = [InformacionIFFT(N-PC+1:end); InformacionIFFT];%Prefijo ciclico
        InformacionAWGN = awgn(InformacionPc, SNR(i), 'measured');%Canal AWGN
        InformacionNoPc = InformacionAWGN(N/4+1:end);
        InformacionFFT = fft(InformacionNoPc);
        InformacionDemodulada = demodulador(InformacionFFT,m)'; %Demodulacion
        [ne, BER(k)] = biterr(informacion, InformacionDemodulada);
    end
    BERProm(i) = mean(BER);
end

EbN0 = 10.^(EbN0_dB/10);
semilogy(EbN0_dB, BERProm,'->')
hold on
%BER teorico
BER_teor = berawgn(EbN0_dB,'psk',M,'nondiff');
semilogy(EbN0_dB, BER_teor,'-*')
grid on
legend ('Simulado OFDM','Teorico AWGN');
title('Modulacion QPSK');
xlabel('Eb/No');
ylabel('BER');

