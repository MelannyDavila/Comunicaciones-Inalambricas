function [Loss] = ha(d, f, h_tx, h_rx, cobertura, area)
a = 0;
d=d/1000;
while a == 0
    a = 1;
    if cobertura == 1 || cobertura == 2 %pequeno o mediano
        c_rx = 0.8 + (1.1*log10(f)- 0.7 )*h_rx - 1.56*log10(f);
    elseif cobertura == 3 %grande
        if f >= 150 && f<=200
            c_rx = 8.29*(log10(1.54*h_rx))^2 - 1.1;
        elseif f >= 200 && f<=1.5e3
            c_rx = 3.2*(log10(11.75*h_rx))^2 - 4.97;
        else
            disp('Frecuencia incorrecta')
        end
    else
        disp('Opcion incorrecta')
        a = 0; 
    end
    Loss1=69.55 + 26.16*log10(f) - (13.82*log10(h_tx)) - c_rx + (44.9 - (6.55*log10(h_tx)))*log10(d);
    if area == 1 %urbano
        Loss = 69.55 + 26.16*log10(f) - (13.82*log10(h_tx)) - c_rx + (44.9 - (6.55*log10(h_tx)))*log10(d);
    elseif area == 2 %suburbano
        Loss = Loss1 - 2*(log10(f/28))^2 - 5.4;
    elseif area == 3 %abierta
        Loss = Loss1 - 4.78*(log10(f))^2 + 18.33*log10(f) - 40.97;
    else 
        disp('Opcion incorrecta')
        a = 0;
    end
end
end