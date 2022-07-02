clear, clc;

%********* CARGAMOS LOS DATOS 
load('datosADSL.mat');
y = datosADSL;

% La frecuencia m�xima de la se�al es 1.104e6 Hz
Fs = 2 * 1.104e6;
Ts = 1/Fs;

x=[0:1:length(y)-1];
x=x*Ts;

%{
%********* GRAFICAMOS datosADSL 
plot(x,y);
xlabel('Tiempo [s]');
ylabel('Magnitud');
%}


%********* SACAMOS LA TRANSFORMADA
n = 2^21;
Y=fft(y,n);
% 2^21 es la potencia de 2 inmediatamente superior a la longitud de la
% muestra

frec=[-Fs/2 : Fs/n : Fs/2 - Fs/n];

%********* GRAFICAMOS LA TRANSFORMADA EN FUNCI�N DE FREQ. CONTINUAS
plot(frec,fftshift(abs(Y)));
xlabel('Frecuencia [Hz]');
ylabel('Magnitud');

k_voz_i = floor((300/Fs) * n);
k_voz_s = ceil((3400/Fs) * n);

filtervoz = zeros(n,1);
filtervoz(k_voz_i:k_voz_s) = 1;
filtervoz(n - k_voz_s:n - k_voz_i) = 1;

VOZ = filtervoz .* Y;

%plot(frec,abs(fftshift(VOZ)));

%plot(VOZ(:,k_voz_i:k_voz_s));

voz = real(ifft(VOZ,n));

Fs_audio = 2^13;

%soundsc(voz);
y_resample = resample(voz, Fs_audio, Fs);
soundsc(y_resample, Fs_audio);
soundsc(y_resample, Fs_audio*2);
soundsc(y_resample, Fs_audio/2);