function [h_ray] = canal_rayleigh(num, sigma)
    X = randn(1, num); %Creacion X
    Y = 1j*randn(1, num); %Creacion Y
    h_ray = sigma*(X+Y);
end

