clc
clear all
close all
format long
num = 1e6;
m = 1; %Modulacion BPSK
EbN0_dB = 0:10;
SNR = EbN0_dB + 10.*log10(m);
L = num * m; %Longitud del tren de bits
% Parte Rician
K_dB = 6;
K = 10.^(K_dB/10); %Transformado a veces
omega = 1;


for i = 1:length(EbN0_dB)
    bits = randi([0 1], 1, L); %tren de bits
    x = modulador(bits, m); %Funcion moduladora
    hric = canalRician(num, K, omega);
    hric_res = reshape(hric, num, 1);
    
    y = x.*hric_res;
    es_1 = awgn(x, SNR(i), 'measured');
    es_2 = awgn(y, SNR(i),'measured');
    x_est = es_2./hric_res;
    
    es1_dem = demodulador(es_1, m)'; %Funcion demoduladora
    es2_dem = demodulador(es_2, m)';
    es3_dem = demodulador(x_est, m)';
    [ne1, BER_AWG(i)] = biterr(bits, es1_dem);
    [ne2, BER_RIC(i)] = biterr(bits, es2_dem);
    [ne3, BER_RIC_EC(i)] = biterr(bits, es3_dem);
end

ber = berfading(EbN0_dB, 'psk', 2, 1, K);

semilogy(EbN0_dB, BER_AWG,'r')
hold on
semilogy(EbN0_dB, BER_RIC,'g--o')
hold on
semilogy(EbN0_dB, BER_RIC_EC,'b-o')
hold on
semilogy(EbN0_dB, ber,'k')

title('BER vs Eb/No para BPSK canal Rician')
xlabel('Eb/No [dB]')
ylabel('BER')
legend('Simulado AWGN','Sim Rician sin ecualizador','Sim Rician con ecualizador', 'Rician Teórico')
grid on; grid minor
