%load('datosADSL.mat');

clear, clc;

load gong.mat;

Fs = 2208001;
Ts = 1/Fs;
n = 2097152;

y=datosADSL;
x=[0:1:length(y)-1];

x=x*Ts;

%plot(x,y);

%********* SACAMOS LA TRANSFORMADA
Y=fft(y,n);

YY=abs(y);
frec=[0:2*pi/length(YY):2*pi];
frec=frec(:,1:length(YY));

%********* GRAFICAMOS LA TRANSFORMADA
plot(frec,YY);xlabel('frecuencia w [rad/seg]');
ylabel('Magnitud');

k_voz_i = floor((300/Fs) *length(YY));
k_voz_s = ceil((3400/Fs) *length(YY));

filtervoz = [zeros(1,k_voz_i),ones(1,k_voz_s-k_voz_i),zeros(1,length(YY)-k_voz_s)];

VOZ = filtervoz .* YY';

plot(VOZ(:,k_voz_i:k_voz_s));

voz = ifft(VOZ);