clear all, clc;

n = 0:1:10;
x = (0.9).^n;

[X, wk] = DTFT(x,1000);

subplot(311), plot(wk, abs(X));
subplot(312), plot(wk, angle(X));
subplot(313), plot(wk, abs(X).^2);