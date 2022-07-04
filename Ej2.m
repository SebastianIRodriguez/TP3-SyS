clear, clc;

[y, Fs, Nbits] = wavread('tonos.wav');

leny = length(y);

h = fir1(80, 0.325);

frec = [-Fs / 2:Fs / leny:Fs / 2 - Fs / leny];

Y = fft(y);

tiempo = [0:(1/Fs):(leny/Fs) - (1/Fs)];

%********* SEÑAL EN FUNCIÓN DEL TIEMPO
plot(tiempo, y);
grid on;
axis tight;
xlabel('Tiempo [s]');
set(gca, 'xtick', 0:0.45:6);
ylabel('Amplitud');
title('Tonos.wav', 'FontWeight', 'bold');

%********* GRAFICAMOS LA TRANSFORMADA EN FUNCIÓN DE FREQ. CONTINUAS
%{
plot(frec, fftshift(abs(Y)));
grid on;
axis tight;
xlabel('Frecuencia [Hz]');
ylabel('Magnitud');
title('Espectro de tonos.wav', 'FontWeight', 'bold');
%}

frame_length = floor(450e-3 * Fs);

H = fft(h, frame_length);

% kdiv divide en dos sexiones la transformada, siendo los k menores a kdiv
% correspondientes a las bajas frecuencias y los k mayores a las altas frecuencias

kdiv = 1000 * frame_length / Fs;

num = h;
den = [1 zeros(1, length(num) - 1)];

%yfiltrada=filter(num,den,y);
yfiltrada = y;

for i = 1:(leny / frame_length)

    frame_start = frame_length * (i - 1) + 1;
    frame_end = frame_length * i;

    frame = yfiltrada(frame_start:frame_end, 1);

    Y_ventana = abs(fft(frame));

    [~, k_low] = max(Y_ventana(1:kdiv));
    [~, k_high] = max(Y_ventana(kdiv:length(Y_ventana) / 2));

    freq_low = k_low * Fs / frame_length;
    freq_high = (k_high + kdiv) * Fs / frame_length;

    discado(i) = Determinar_digito(freq_low, freq_high);
end

% En cada posición de "discado" queda guardado el caracter correspondiente,
% de ser inválido guarda un espacio
discado

%plot(h);

for i = 1:(leny / frame_length)

    frame_start = frame_length * (i - 1) + 1;
    frame_end = frame_length * i;

    frame = y(frame_start:frame_end, 1);

    Y_ventana = abs(fft(frame) .* H');

    [~, k_low] = max(Y_ventana(1:kdiv));
    [~, k_high] = max(Y_ventana(kdiv:length(Y_ventana) / 2));

    freq_low = k_low * Fs / frame_length;
    freq_high = (k_high + kdiv) * Fs / frame_length;

    %freq_low = min([freq1, freq2])
    %freq_high = max([freq1, freq2])

    discado(i) = Determinar_digito(freq_low, freq_high);
end

discado

%plot(h);
