clc
clear all
close all
disp('Ingrese el numero de estados de modulacion a utilizar')
m = input('a. BPSK b.4-QAM c.16-QAM: '); 
%Numero de simbolos
N = input('Ingrese el valor de N: ');
%Creacion del vector de informacion
informacion = randi([0 m-1],1, N*m)'; 
%Validacion de los estados de modulacion
if m == 2 || m == 4 || m == 16 
    %Modulacion los datos
    informacionModulada = modulador(informacion, m); 
else
    disp('Opcion no valida')
end
%Demodulacion de la senal modulada
informacionDemodulada = demodulador(informacionModulada, m);

