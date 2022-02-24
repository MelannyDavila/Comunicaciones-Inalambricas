clc, clear all, close all
disp('Seleccione el numero del modelo con el que desea trabajar:')
disp('1. Free space path loss model')
disp('2. Log-normal path loss model')
disp('3. Hata model')
disp('4. Salir');
opcion = input('\n Opcion:  ');
while opcion ~= 4
    disp('Seleccione el numero del modelo con el que desea trabajar:')
    disp('1. Free space path loss model')
    disp('2. Log-normal path loss model')
    disp('3. Hata model')
    disp('4. Salir\n');
    opcion = input('Opcion:  ');
    switch opcion
        case 1
            d = input('Ingrese la distancia en [m]: ');
            f = input('Ingrese la frecuencia en [MHz]: ');
            perdidas = fs(d, f);
            fprintf("Las perdidas por trayecto son: %.2f [dB]\n", perdidas)
        case 2
            d = input('Ingrese la distancia en [m]: ');
            f = input('Ingrese la frecuencia en [MHz]: ');
            d_O = input('Ingrese d_O [m]: ');
            n = input('Ingrese el n: ');
            perdidas = ln(d, f, n, d_O);
            fprintf("Las perdidas por trayecto son: %.2f [dB]\n", perdidas)
        case 3
            d = input('Ingrese la distancia en [m]: ');
            f = input('Ingrese la frecuencia en [MHz]: ');
            h_tx = input('Ingrese la altura del transmisor [m]: ');
            h_rx = input('Ingrese la altura del receptor [m]: ');
            disp('Seleccione el tamano de la cobertura')
            disp('1. Pequeno')
            disp('2. Mediano')
            disp('3. Grande')
            cobertura = input('Ingrese la opcion: ');
            disp('Seleccione el area de trabajo')
            disp('1. Urbana')
            disp('2. Suburbana')
            disp('3. Abierta')
            area = input('Ingrese la opcion: ');
            perdidas = ha(d, f, h_tx, h_rx, cobertura, area);
            fprintf("Las perdidas por trayecto son: %.2f [dB]\n", perdidas)
    end
end