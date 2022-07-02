clear, clc;

[y, Fs, Nbits] = wavread('tonos.wav');

%{
Con la ayuda de las funciones fft y fftshift de Matlab compute la DTFT de la señal Y completa y
grafique el espectro de amplitud en función de la frecuencia en tiempo continuo asociada, en el rango
entre [-Fs/2 , Fs/2]. Indique si es posible o no determinar el número marcado a partir del espectro de
amplitud de la señal completa.
%}

leny = length(y);

h=fir1(80,0.325);

frec = [-Fs / 2:Fs / leny:Fs / 2 - Fs / leny];

Y = fft(y);

%********* GRAFICAMOS LA TRANSFORMADA EN FUNCIÓN DE FREQ. CONTINUAS
plot(frec, fftshift(abs(Y)));
xlabel('Frecuencia [Hz]');
ylabel('Magnitud');

frame_length = floor(450e-3 * Fs);

H = fft(h, frame_length);

kdiv = 1000 * frame_length / Fs;

num=fir1(80,0.325);
den=[1 zeros(1,length(num)-1)];

yfiltrada=filter(num,den,y);

for i = 1: (leny / frame_length)
    
    frame_start = frame_length * (i - 1) + 1;
    frame_end = frame_length * i;
    
    frame = yfiltrada(frame_start:frame_end, 1);
    
    Y_ventana = abs(fft(frame));
    
    [~, k_low] = max(Y_ventana(1:kdiv));
    [~, k_high] = max(Y_ventana(kdiv:length(Y_ventana)/2));

    freq_low = k_low * Fs / frame_length;
    freq_high = (k_high + kdiv) * Fs / frame_length;
    
    %freq_low = min([freq1, freq2])
    %freq_high = max([freq1, freq2])
    
    discado(i) = Determinar_digito(freq_low, freq_high);
end

discado

plot(h);

for i = 1: (leny / frame_length)
    
    frame_start = frame_length * (i - 1) + 1;
    frame_end = frame_length * i;
    
    frame = y(frame_start:frame_end, 1);
    
    Y_ventana = abs(fft(frame) .* H');
    
    [~, k_low] = max(Y_ventana(1:kdiv));
    [~, k_high] = max(Y_ventana(kdiv:length(Y_ventana)/2));

    freq_low = k_low * Fs / frame_length;
    freq_high = (k_high + kdiv) * Fs / frame_length;
    
    %freq_low = min([freq1, freq2])
    %freq_high = max([freq1, freq2])
    
    discado(i) = Determinar_digito(freq_low, freq_high);
end

discado

plot(h);




%{
load('handel')
F_Mi=220*2^(7/12);
F_Resos=220*2^(6/12);
F_Fa=220*2^(8/12);
w1=2*F_Resos/Fs;
w2=2*F_Fa/Fs;
N=1000;
num=fir1(N,[w1 w2],'stop');
den=[1 zeros(1,length(num)-1)];
filtro=tf(num,den,1/Fs);
[mag,fase,w]=bode(filtro);
% subplot(211)
% plot(w/(2*pi),mag(:))
% subplot(212)
% plot(w/(2*pi),fase(:))
t=[0:1/Fs:(length(y)-1)/Fs]';
ruido_Mi=0.3*sin(2*pi*F_Mi*t);
yruidosa=y+ruido_Mi;
yfiltrada=filter(num,den,yruidosa);
Nf=2^17;
Y=fft(y,Nf);
Yruidosa=fft(yruidosa,Nf);
Yfiltrada=fft(yfiltrada,Nf);
F=[-Fs/2:Fs/Nf:Fs/2-Fs/Nf]';
figure
plot(F,abs(fftshift(Yruidosa)))
figure
plot(F,abs(fftshift(Yfiltrada)),F,abs(fftshift(Y)))
%}