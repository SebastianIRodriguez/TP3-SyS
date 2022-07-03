clear, clc;

%********* CARGAMOS LOS DATOS 
load('datosADSL.mat');
y = datosADSL;

% La frecuencia maxima de la senal es 1.104e6 Hz
Fs = 2 * 1.104e6;

%********* GRAFICAMOS datosADSL
%{
figure
t = (0 : 1 : length(y)-1) * Ts;
plot(t,y,'color', [0 0.4470 0.7410],'LineSmoothing','on');
grid on;
axis([-0.05 0.65 -200 20]);
xlabel('Tiempo [s]');
ylabel('Magnitud');
%}


%********* SACAMOS LA TRANSFORMADA
n = 2^21;
Y=fft(y,n);
% 2^21 es la potencia de 2 inmediatamente superior a la longitud de la
% muestra

frec=-Fs/2 : Fs/n : Fs/2 - Fs/n;

%********* GRAFICAMOS LA TRANSFORMADA EN FUNCION DE FREQ. CONTINUAS
%{
figure
plot(frec,fftshift(abs(Y)),'color', [0 0.4470 0.7410],'LineSmoothing','on');
grid on;
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
%}

%********* FILTRAMOS CANAL DE VOZ
k_voz_i = floor((300/Fs) * n);
k_voz_s = ceil((3400/Fs) * n);

filtervoz = zeros(n,1);
filtervoz(k_voz_i:k_voz_s) = 1;
filtervoz(n - k_voz_s:n - k_voz_i) = 1;

VOZ = filtervoz .* Y;
subplot(311), plot(frec,abs(fftshift(VOZ)),...
    'color', [0.8500 0.3250 0.0980], 'LineSmoothing', 'on');
grid on;
axis tight;
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
title('Canal VOZ', 'FontWeight', 'bold')

%********* FILTRAMOS CANAL UPSTREAM
k_up_i = floor((25875/Fs) * n);
k_up_s = ceil((138000/Fs) * n);

filter_upstream = zeros(n,1);
filter_upstream(k_up_i:k_up_s) = 1;
filter_upstream(n - k_up_s:n - k_up_i) = 1;

UPSTREAM = filter_upstream .* Y;
subplot(312), plot(frec,abs(fftshift(UPSTREAM)),...
    'color', [0.4660 0.6740 0.1880], 'LineSmoothing', 'on');
grid on;
axis tight;
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
title('Canal UPSTREAM', 'FontWeight', 'bold')

%********* FILTRAMOS CANAL DOWNSTREAM
k_down_i = floor((138000/Fs) * n);
k_down_s = ceil((1104000/Fs) * n);

filter_downstream = zeros(n,1);
filter_downstream(k_down_i:k_down_s) = 1;
filter_downstream(n - k_down_s:n - k_down_i) = 1;

DOWNSTREAM = filter_downstream.* Y;
subplot(313), plot(frec,abs(fftshift(DOWNSTREAM)),...
    'color', [0 0.4470 0.7410], 'LineSmoothing', 'on');
grid on;
axis tight;
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
title('Canal DOWNSTREAM', 'FontWeight', 'bold')

%********* RECUPERAMOS SENAL DE VOZ

voz = real(ifft(VOZ,n));

Fs_audio = 2^13;

y_resample = resample(voz, Fs_audio, Fs);
soundsc(y_resample, Fs_audio);
%soundsc(y_resample, Fs_audio*2);
%soundsc(y_resample, Fs_audio/2);