clc
clear all
close all
load rician_2_PER_SIM_FINO_50.mat


figure(1)
plot(SNRT(3,:),PERT(3,:),SNRT(5,:),PERT(5,:))
hold on
grid on
grid minor

clear all
load rician_2_PER_SIM_FINO_200.mat
plot(SNRT(3,:),PERT(3,:),SNRT(5,:),PERT(5,:))
axis([0 30 0 1])
title('PER vs. SNR 802.11p')
ylabel('PER')
xlabel('SNR')
legend('QPSK, 1/2, 6 Mbps con 50 bytes','16QAM, 1/2, 12 Mbps con 50 bytes','QPSK, 1/2, 6 Mbps con 200 bytes','16QAM, 1/2, 12 Mbps con 200 bytes')
