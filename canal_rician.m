function hric = canal_rician(num, K_dB, omega)
%Canal Rician, usa el canal Rayleigh
K = 10.^(K_dB/10); %Cambio en veces
hray = canal_rayleigh(num,1/sqrt(2));
hric = sqrt(K./((K+1).*omega)) + omega/sqrt(K+1)*hray;
end

