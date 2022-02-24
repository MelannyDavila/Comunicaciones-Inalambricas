function[hric]=rician(num,k1,oh,des)
des=1/sqrt(2);
hray=rayleigh(num,des);
hric=(sqrt(k1/(k1+1)*oh))+(oh/sqrt(k1+1))*hray;
end
