clc
clear all
close all
format long
N = 64;
m = 2; %Se elige para M-QAM
EbN0_dB = 0:10;
SNR = EbN0_dB + 10.*log10(m);
L = N * m; %Longitud del tren de bits
PC = N/4;
Ntrials = 1000;
informacion = randi([0 1], 1, L); %tren de bits
for i = 1:length(EbN0_dB)
    for k = 1:Ntrials
        
        InformacionModulada = modulador(informacion, m); %Funcion moduladora
        InformacionIFFT = ifft(InformacionModulada); %Aplico ifft, resultado en paralelo
        InformacionPc = [InformacionIFFT(N-PC+1:end); InformacionIFFT];
        InformacionAWGN = awgn(InformacionPc, SNR(i), 'measured');
        InformacionNoPc = InformacionAWGN(N/4+1:end);
        InformacionFFT = fft(InformacionNoPc);
        InformacionDemodulada = demodulador(InformacionFFT,m)'; %Funcion demoduladora
        [ne, BER(k)] = biterr(informacion, InformacionDemodulada);
    end
    BERProm(i) = mean(BER);
end

EbN0 = 10.^(EbN0_dB/10);
semilogy(EbN0_dB, BERProm,'-r','Linewidth',2)
hold on
BER_teor = berawgn(EbN0_dB,'psk',m^2,'nondiff');
semilogy(EbN0_dB, BER_teor,'*k')
title('BER vs Eb/No para QPSK')
xlabel('Eb/No [dB]')
ylabel('BER')
legend('Simulada','Teorico')
grid on; grid minor
