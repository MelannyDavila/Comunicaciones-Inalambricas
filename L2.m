%% Primera pregunta
clc, clear all, close all
%Declaro variables
num = 1e6;
sigma = 1/sqrt(2);
%Rayleigh simulado
h_ray = canal_rayleigh(num, sigma);
%Realizo la simulación del canal Rayleigh
figure(1)
subplot(2,2,1)
histograma_simulado_rayleigh = histogram(abs(h_ray));%Grafico histogramas
title('Simulacion del canal Rayleigh')
axis([0 4 0 18e3])
%Rayleigh teorico
x = linspace(0,4, 1e6);%Creo 1M de muestras con la misma separacion del 0 al 4
pdf_rayleigh_teorica =  (x./sigma^2).*exp(-x.^2/(2*sigma^2));%Uso la funcion de la PDF de Rayleigh
subplot(2,2,2), plot(x,pdf_rayleigh_teorica)
title('Canal Rayleigh teórico')
%Realizo la simulación del canal Rician
%Rician simulado
kdB = 10;%Tomo el valor de K en dB
k = 10^(kdB/10);%convierto el valor de K a veces
omega = 1;
h_ric = canal_rician(num, k, omega);%Llamo a la funcion rician
%figure(2)
subplot(2,2,3)
histograma_simulado_rician = histogram(abs(h_ric));%Grafico histogramas
title('Simulacion del canal Rician')
axis([0 4 0 18e3])
%Rician teorico
%Como la ecuacion es demasiado larga, se ha dividio en partes para obtener
%el resultado
pdf_rician_teorica_1 = (x.*2*(k+1))/omega.*exp(-k-(((k+1).*x.^2)/omega));
pdf_rician_teorica_2 = (x.*2*sqrt((k*(k+1))/omega)).*besseli(1,x);
pdf_rician_teorica_total = pdf_rician_teorica_1.*pdf_rician_teorica_2;
subplot(2,2,4)
plot(x,pdf_rician_teorica_total)
title('Canal Rician teórico')
%% Segunda pregunta
clc, clear all, close all
numBits = 100;%Defino el numero de bits que se van a usar
bits = randi([0 1], numBits,1);%Genero 100 bits aleatorios
Fs = 500e3;%Frecuencia de muestreo
Fd = 200;%Frecuencia Doppler
%Defino la ganancia y los retrasos
apg = [0 -2 -4 6]; %Average path Gains en dB
pd = [0 4 8 12]*10e-6; %Path delays (en s)
%Valores con los que se obtiene resultados mas precisos (especialmente para
%el escenario 2)
% pd = (0:5:15)*1e-6; %Path delays (en s)
% apg  = [0 -3 -6 -9];%Average path Gains en dB
%Creo el modulador qpsk, se coloca en verdadero la opcion de entrada de
%bits, caso contrario se deben ingresar numeros desde 0 hasta M-1
qpskModulator = comm.QPSKModulator('BitInput',true);
infomodulada = qpskModulator(bits);%Obtengo la señal modulada
%Creo objeto para el canal Rayleigh
rayleighchan = comm.RayleighChannel(...
    'SampleRate',Fs, ...
    'PathDelays',pd, ...
    'AveragePathGains',apg, ...
    'MaximumDopplerShift',Fd);

%Creo objeto para el canal Rician
ricianchan = comm.RicianChannel(...
    'SampleRate',Fs,...
    'PathDelays',pd,...
    'AveragePathGains',apg);
%La informacion pasa a traves del canal rayleigh
rayleighchan(infomodulada);
%La informacion pasa a traves del canal rician
ricianchan(infomodulada);
%Libero los objetos para poder cambiar sus parametros
release(rayleighchan);
release(ricianchan);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Escenario 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Con la alteracion del siguiente campo se obtiene la respuesta impulsiva
%la respuesta en frecuencia del canal
rayleighchan.Visualization ='Impulse and frequency responses';
rayleighchan.SamplesToDisplay = '25%';%Se muestran todas las muestras
%se usan varias tramas para poder tener un resultado mas claro visualmente
numFrames = 2;
%Creo el objeto de diagrama de constelacion
constDiag = comm.ConstellationDiagram( ...
    'Name','Señal recibida luego del desvanecimiento');
for i = 1:numFrames
    bits = randi([0 1], numBits,1);%Genero 100 bits aleatorios
    infomodulada = qpskModulator(bits);%se modula la señal
    rayChanOut = rayleighchan(infomodulada);%la señal atraviesa el canal
    constDiag(rayChanOut);
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Escenario 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
release(rayleighchan);%Se libera el objeto para poder alterar sus parametros
%Nuevamente se coloca que se busca la respuesta impulsiva y la respuesta en
%frecuencia 
rayleighchan.Visualization = 'Impulse and frequency responses';
rayleighchan.SampleRate = 20e3;%Se redefine la frecuencia de muestreo
rayleighchan.SamplesToDisplay = '100%';%Se ve solo el 25% de las muestras para mejorar la visualizacion del grafico
numFrames = 2;
constDiag = comm.ConstellationDiagram( ...
    'Name','Señal recibida luego del desvanecimiento');
for i = 1:numFrames
    bits = randi([0 1], numBits,1);
    infomodulada = qpskModulator(bits);
    rayChanOut = rayleighchan(infomodulada);
    constDiag(rayChanOut);
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Escenario 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
release(rayleighchan);%Se libera el objeto para poder alterar sus parametros
%Nuevamente se coloca que se busca la respuesta impulsiva y la respuesta en
%frecuencia 
rayleighchan.PathDelays = 0;
rayleighchan.AveragePathGains = 0;
numFrames = 2;
constDiag = comm.ConstellationDiagram( ...
    'Name','Señal recibida luego del desvanecimiento');
for i = 1:numFrames
    bits = randi([0 1], numBits,1);
    infomodulada = qpskModulator(bits);
    rayChanOut = rayleighchan(infomodulada);
    constDiag(rayChanOut);
end