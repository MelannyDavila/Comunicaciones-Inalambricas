function [loss] = fs(d,f)
    %La funcion considera la frecuencia en MHz
    lambda = 3e8/(f*1e6);
    loss = 20*log10(4*pi*d/lambda);
end
