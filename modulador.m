function d_mod = modulador(bits, m)
bpskModulator = comm.BPSKModulator; %Creo el objeto para BPSK
%bits = reshape(bits,[m length(bits)/m]); %Se ubican los bits para hacer smb
%datos = bi2de(bits');%Se transforma a simbolos para las modulaciones
if m == 1
    d_mod = bpskModulator(bits');%Se envia directamente los bits
else
    d_mod = qammod(bits', 2^m,'InputType','bit');
end

end