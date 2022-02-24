clear all
close all
clc
load rician_2_PER_SIM_FINO_50.mat
figure(1)
for i=1:8 
semilogy(SNRT(i,:),BERT(i,:))
hold on
end
grid on
grid minor
axis([0 30 10e-4 10e-2])
title('BER vs. SNR 802.11p')
ylabel('BER')
xlabel('SNR')
legend('BPSK, 1/2, 3 Mbps','BPSK, 3/4, 4.5 Mbps','QPSK, 1/2, 6 Mbps',...
    'QPSK, 3/4, 9 Mbps','16QAM, 1/2, 12 Mbps','16QAM, 3/4, 18 Mbps',...
    '64QAM, 2/3, 24 Mbps','64QAM, 3/4, 27 Mbps')
%%
figure(2)
for i=1:8 
plot(SNRT(i,:),PERT(i,:))
hold on
end
grid on
grid minor
axis([0 40 0 1])
title('PER vs. SNR 802.11p')
ylabel('PER')
xlabel('SNR')
legend('BPSK, 1/2, 3 Mbps','BPSK, 3/4, 4.5 Mbps','QPSK, 1/2, 6 Mbps',...
    'QPSK, 3/4, 9 Mbps','16QAM, 1/2, 12 Mbps','16QAM, 3/4, 18 Mbps',...
    '64QAM, 2/3, 24 Mbps','64QAM, 3/4, 27 Mbps')
