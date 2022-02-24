clc
clear all
close all
%Datos
n=1e5;%Numero de bits
Eb_N0=0:10; %Vector de energia de bits
%des=1/sqrt(2);
bits= randi([0 1],n,1);%bits transmitidos
sigma=1/sqrt(2);%Factor sigma
nRx_max=length(Eb_N0);
nRx=[1:nRx_max];
snr_sim_EGC = zeros(1, length(Eb_N0));
for i=1:length(Eb_N0)
    % Curva 1
    m = 1;%Numero de bits por simbolos
    M = 2^m;%Numero de estados BPSK
    SNR1 = Eb_N0+10*log10(m);%Transformacion a SNR
    InformacionModulada = modulador(bits,m);%bits modulados BPSK
    InformacionCanal = canal_rayleigh(n,sigma); %canal Rayleigh
    InformacionRayleigh = reshape(InformacionCanal,[],1);%Reformulo el vector
    Producto = InformacionRayleigh.*InformacionModulada;%Producto de hx
    InformacionRuido = awgn(Producto,SNR1(i),'measured');%Ruido AWGN
    InformacionEcualizada = InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
    InformacionDemodulada = demodulador(InformacionEcualizada,m);%bits demodulados BPSK
    [Bit_Er3,BER(i)]= biterr(bits,InformacionDemodulada);%BER
    %Curva 2
    %Primer canal
    SNR1 = Eb_N0+10*log10(m);%Transformacion a SNR
    InformacionModulada_1 = modulador(bits,m);%bits modulados BPSK
    InformacionCanal_1 = canal_rayleigh(n,sigma); %canal Rayleigh
    InformacionRayleigh_1 = reshape(InformacionCanal_1,[],1);%Reformulo el vector
    Producto_1 = InformacionRayleigh_1.*InformacionModulada_1;%Producto de hx
    InformacionRuido_1 = awgn(Producto_1,SNR1(i),'measured');%Ruido AWGN
    %Segundo canal
    SNR2 = Eb_N0+10*log10(m);%Transformacion a SNR
    InformacionModulada_2 = modulador(bits,m);%bits modulados BPSK
    InformacionCanal_2 = canal_rayleigh(n,sigma); %canal Rayleigh
    InformacionRayleigh_2 = reshape(InformacionCanal_2,[],1);%Reformulo el vector
    Producto_2 = InformacionRayleigh_2.*InformacionModulada_2;%Producto de hx
    InformacionRuido_2 = awgn(Producto_2,SNR2(i),'measured');%Ruido AWGN
    %Metodo de diversidad
    senialDiversidad_1 = ((conj(InformacionRayleigh_1).*InformacionRuido_1)+...
        (conj(InformacionRayleigh_2).*InformacionRuido_2));
    senialDiversidad_2 =  abs(InformacionRayleigh_1).^2+...
        abs(InformacionRayleigh_2).^2;
    senialDiversidad = senialDiversidad_1./senialDiversidad_2;
    InformacionDemodulada = demodulador(senialDiversidad,m);%bits demodulados BPSK
    [Bit_Er3, BER_2(i)] = biterr(bits,InformacionDemodulada);%BER
    % Curva 3
    SNR1 = Eb_N0+10*log10(m);%Transformacion a SNR
    InformacionModulada_1 = modulador(bits,m);%bits modulados BPSK
    InformacionCanal_1 = canal_rayleigh(n,sigma); %canal Rayleigh
    InformacionRayleigh_1 = reshape(InformacionCanal_1,[],1);%Reformulo el vector
    Producto_1 = InformacionRayleigh_1.*InformacionModulada_1;%Producto de hx
    InformacionRuido_1 = awgn(Producto_1,SNR1(i),'measured');%Ruido AWGN
    %Segundo canal
    SNR2 = Eb_N0+10*log10(m);%Transformacion a SNR
    InformacionModulada_2 = modulador(bits,m);%bits modulados BPSK
    InformacionCanal_2 = canal_rayleigh(n,sigma); %canal Rayleigh
    InformacionRayleigh_2 = reshape(InformacionCanal_2,[],1);%Reformulo el vector
    Producto_2 = InformacionRayleigh_2.*InformacionModulada_2;%Producto de hx
    InformacionRuido_2 = awgn(Producto_2,SNR2(i),'measured');%Ruido AWGN
    %Metodo de diversidad 
    senialDiversidad = (exp(angle(InformacionRayleigh_1)*(-1i)).*InformacionRuido_1)+...
        (exp(angle(InformacionRayleigh_2)*(-1i)).*InformacionRuido_2);
    InformacionDemodulada = demodulador(senialDiversidad,m);%bits demodulados BPSK
    [Bit_Er3, BER_3(i)] = biterr(bits,InformacionDemodulada);%BER    
end

Eb_N0 = 10.^(Eb_N0/10);
Nr = 2;
% Curva 5
for i=1:length(Eb_N0)
    rho = 0.5-(0.5*(1+(1/Eb_N0(i)))^(-0.5));
    sumatoria1 = 0;
    for j=0:Nr-1
        aux = nchoosek(Nr-1+j, j)*(1-rho)^j;
        sumatoria1 = sumatoria1 + aux;
    end
    BER_5(i) = (rho^Nr)*sumatoria1;
end
% Curva 6
%Se mantiene el valor de Nr
BER_6 = 0.5*(1-((sqrt(Eb_N0.*(Eb_N0+2)))./(Eb_N0+1)));

Eb_N0=0:10; %Vector de energia de bits
%Curva 4
BER_4 = berfading(Eb_N0,'psk',2,1);

figure
semilogy(Eb_N0,BER,'-o');
hold on
semilogy(Eb_N0,BER_4,'-*');
hold on
semilogy(Eb_N0,BER_2,'-x');
hold on
semilogy(Eb_N0,BER_3,'-+');
grid on
semilogy(Eb_N0,BER_6,'-<');
grid on
semilogy(Eb_N0,BER_5,'->');
grid on
title('BER vs. Eb/No, Diversidad')
xlabel('Eb/No')
ylabel('BER')
legend('Nt=1 Nr=1 sim','Nt=1 Nr=1 teorico',...
    'Nt=1 Nr=2 MRC sim.','Nt=1 Nr=2 EGC sim', ...
    'Nt=1 Nr=2 EGC teorico', 'Nt=1 Nr=2 MRC teorico');
