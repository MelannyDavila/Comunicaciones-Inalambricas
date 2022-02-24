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
m=1;%Numero de bits por simbolos
M=2^m;%Numero de estados BPSK
Nt=1;%Antenas transmisoras
Nr=2;%Antenas receptoras
SNR=Eb_N0+10*log10(m);%Transformacion a SNR
%Curva 1: Simulado sin diversidad Nt=1, Nr=1
for i=1:length(Eb_N0)
    InformacionModulada = modulador(bits,m);%bits modulados BPSK
    InformacionCanal=canal_rayleigh(n,sigma); %canal Rayleigh
    InformacionRayleigh=reshape(InformacionCanal,[],1);%Reformulo el vector 
    Producto=InformacionRayleigh.*InformacionModulada;%Producto de hx
    InformacionRuido=awgn(Producto,SNR(i),'measured');%Ruido AWGN
    InformacionEcualizada=InformacionRuido./InformacionRayleigh;%Compensar con ecualizador
    InformacionDemodulada=demodulador(InformacionEcualizada,m);%bits demodulados 4-QAM
    [Bit_Er3,BER(i)]= biterr(bits,InformacionDemodulada);%BER 
end
figure
semilogy(Eb_N0,BER,'-o');
hold on

%Curva 2: MRC con diversidad en recepcion simulacion
for i=1:length(Eb_N0)
    DatosModulados = modulador(bits,m);%bits modulados
    canal_ray=canal_rayleigh(n,sigma); %canal Rayleigh es h1
    canal_ray2=canal_rayleigh(n,sigma); % %canal Rayleigh es h2
    canal_ray1=reshape(canal_ray,[],1);%Reformulo el vector
    canal_ray2=reshape(canal_ray2,[],1);%Reformulo el vector
    datos1=canal_ray1.*DatosModulados;
    datos2=canal_ray2.*DatosModulados;
    datos_ruido1=awgn(datos1,SNR(i),'measured');%Ruido AWGN
    datos_ruido2=awgn(datos2,SNR(i),'measured');%Ruido AWGN
    %MRC Simulado
    y1=(((conj(canal_ray1)).*datos_ruido1) + ((conj(canal_ray2)).*datos_ruido2))./(((abs(canal_ray1)).^2)+((abs(canal_ray2)).^2));
    DatosDemodulados=demodulador(y1,m);%bits demodulados
    [Bit_Er,BER2(i)]= biterr(bits,DatosDemodulados);%BER
end
semilogy(Eb_N0,BER2,'-*');
hold on

%Curva 3: ERC con diversidad en transmision simulada
for i=1:length(Eb_N0)
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
    [Bit_Er3, BER3(i)] = biterr(bits,InformacionDemodulada);%BER
end
semilogy(Eb_N0,BER3,'-x');
grid on

%Curva 4: Teorico sin diversidad Nt=1, Nr=1
BER4 = berfading(Eb_N0,'psk',M,1);
semilogy(Eb_N0,BER4);
hold on

%Curva 5: ERC con diversidad en transmision teorica
Eb_N01 = 10.^(Eb_N0/10);
BER5 = 0.5*(1-((sqrt(Eb_N01.*(Eb_N01+2)))./(Eb_N01+1)));
semilogy(Eb_N0,BER5);
hold on

%Curva 6: MRC con diversidad en recepcion teorica
Eb_N01 = 10.^(Eb_N0/10);
for i=1:length(Eb_N01)
    rho = 0.5-(0.5*(1+(1/Eb_N01(i)))^(-0.5));
    sumatoria1 = 0;
    for j=0:Nr-1
        aux = nchoosek(Nr-1+j, j)*(1-rho)^j;
        sumatoria1 = sumatoria1 + aux;
    end
    BER6(i) = (rho^Nr)*sumatoria1;
end
semilogy(Eb_N0,BER6);
hold on

ylabel('BER')
xlabel('Eb/N0')
legend( 'Nt=1 Nr=1 sim.','Nt=1 Nr=1 teorico','Nt=1 Nr=2 MRC sim.','Nt=1 Nr=1 EGC teorico','Nt=1 Nr=2 EGC teorico','Nt=1 Nr=2 MRC teorico')
title('BER vs. Eb/No Diversidad')