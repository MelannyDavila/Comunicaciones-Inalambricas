function demmod = demodulador(d_mod, m)
bpskDemodulator = comm.BPSKDemodulator;%Objeto demodulador BPSK
%Opciones de demodulacion
if m == 1
    demmod = bpskDemodulator(d_mod);% Se demodula directamente
    return
else 
    demmod = qamdemod(d_mod, 2^m,'OutputType','bit');
end

%demmod = de2bi(demmod); %Transformamos a binario
%demmod = demmod'; %Transpuesta para la transformacion
%demmod = demmod(:); %Pasamos a tren de bits
end