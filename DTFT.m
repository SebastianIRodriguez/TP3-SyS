function [X, wk] = DTFT(x,N)
    if size(x,2) > 2
        x = x'
    end
    wk = [-pi:2*pi/N:pi-2*pi/N]';
    n = [0:1:length(x)-1]; 
    E = exp(-j*wk*n);
    X = E * x;

end

