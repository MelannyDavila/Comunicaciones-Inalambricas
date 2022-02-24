clc
clear all
close all

% Parte dos 
% Escenario 1
nbits = 100;
s_rate = 500e3; %500KHz ancho de banda
d_frec = 200; % Frecuencia doppler 200;
a_pathgain = [0 -2 -4 -6]; %Dado en dB
p_delays = [0 4 8 12].*10^(-6); % En microseg se pasa a seg

rayleighchan = comm.RayleighChannel(...
    'SampleRate',s_rate,'MaximumDopplerShift', d_frec, ...
    'AveragePathGains', a_pathgain, 'PathDelays', p_delays, ...
    'Visualization','Impulse and frequency responses');
%Creacion de bits  y modulacion
bits = randi([0 1], 1, nbits);
qpskmod = comm.QPSKModulator('BitInput',true);
smodulada = qpskmod(bits');
y = rayleighchan(smodulada);


%% Escenario 2 
nbits = 100;
s_rate = 20e3; %20KHz ancho de banda
d_frec = 200; % Frecuencia doppler 200;
a_pathgain = [0 -2 -4 -6]; %Dado en dB
p_delays = [0 4 8 12].*10^(-6); % En microseg se pasa a seg

rayleighchan = comm.RayleighChannel(...
    'SampleRate',s_rate,'MaximumDopplerShift', d_frec, ...
    'AveragePathGains', a_pathgain, 'PathDelays', p_delays, ...
    'Visualization','Impulse and frequency responses');
%Creacion de bits  y modulacion
bits = randi([0 1], 1, nbits);
qpskmod = comm.QPSKModulator('BitInput',true);
smodulada = qpskmod(bits');
y = rayleighchan(smodulada);

%% Escenario 3
nbits = 100;
s_rate = 20e3; %20KHz ancho de banda
d_frec = 200; % Frecuencia doppler 200;
a_pathgain = [0]; %Dado en dB
p_delays = [0].*10^(-6); % En microseg se pasa a seg
rayleighchan = comm.RayleighChannel(...
    'SampleRate',s_rate,'MaximumDopplerShift', d_frec, ...
    'AveragePathGains', a_pathgain, 'PathDelays', p_delays, ...
    'Visualization','Impulse and frequency responses');
%Creacion de bits  y modulacion
bits = randi([0 1], 1, nbits);
qpskmod = comm.QPSKModulator('BitInput',true);
smodulada = qpskmod(bits');
y = rayleighchan(smodulada);


