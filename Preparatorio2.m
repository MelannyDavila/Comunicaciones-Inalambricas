clc %Se limpia la consola
clear all %Se limpian las variables
close all %Se cierran todas las ventanas adicionales
A=[2 7 0 5 1 4; 1 2 1 2 1 2; 0 4 7 3 11 12; 1 4 7 9 5 0; ...
   11 21 4 3 2 1]; %Definicion de la matriz A
disp('Matriz Original:') %Impresion del mensaje
disp(A) %Presentacion de la matriz A
Atrans=A'; %Obtencion de la matriz transpuerta de A
disp('Matriz Transpuesta:') %Impresion del mensaje
disp(Atrans)%Presentacion de la matriz transpuesta de A
AM=-2*A;%Multiplicacion de la matriz A por el escalar -2
disp('Matriz multiplicada por el escalar -2:') %Impresion del mensaje
disp(AM) %Presentacion de  la nueva matriz obtenida 
AF3=A(3,:);
disp('Elementos de la fila 3:') %Impresion del mensaje
disp(AF3) %Presentacion de la fila 3 de la matriz A
SMatr=A([2,3,4],[2,3,4,5]); %Obtencion de la submatriz
disp('Sub-matriz obtenida:') %Impresion del mensaje
disp(SMatr)%Presentacion de la submatriz
A1=randi(10,5,6); %Creacion de una matriz aleatoria de 5x6
NMatr=A.*A1; %Obtencion del producto entre matrices
disp('Producto entre A y una nueva matriz:')%Impresion del mensaje
disp(NMatr)%Presentacion de la matriz resultante