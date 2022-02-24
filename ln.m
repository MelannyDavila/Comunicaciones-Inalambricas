function [loss] = ln(d,f,n, d_O)
    loss = fs(d_O,f) + 10*n*log10(d/d_O);
end

