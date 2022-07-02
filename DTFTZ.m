function [X, wk] = DTFTZ(num, den, N)
 
    wk = [-pi:2*pi/N:pi-2*pi/N]';
    z = exp(j * wk);
    X = polyval(num,z) ./ polyval(den,z);

end