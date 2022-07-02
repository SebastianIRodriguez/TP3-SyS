clc, clear all;

num = [1 0];
den = [1 -0.9];

[X, wk] = DTFTZ(num, den, 2000);

subplot(311), plot(wk, abs(X));
subplot(312), plot(wk, angle(X));
subplot(313), plot(wk, abs(X).^2);