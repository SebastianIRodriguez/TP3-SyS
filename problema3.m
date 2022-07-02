clear all, clc;

L = 500;
n = [0:1:L-1];
x = cos(0.5*pi*n) + cos(0.51*pi*n);

[X, wk] = DTFT(hamming(L)' .* x,5000);

figure

subplot(311), plot(wk, abs(X));
subplot(312), plot(wk, angle(X));
subplot(313), plot(wk, abs(X).^2);

[X, wk] = DTFT(hanning(L)' .* x,5000);

figure

subplot(311), plot(wk, abs(X));
subplot(312), plot(wk, angle(X));
subplot(313), plot(wk, abs(X).^2);

[X, wk] = DTFT(boxcar(L)' .* x,5000);

figure

subplot(311), plot(wk, abs(X));
subplot(312), plot(wk, angle(X));
subplot(313), plot(wk, abs(X).^2);