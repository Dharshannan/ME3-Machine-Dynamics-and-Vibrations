wave = audioread('Dadadida.m4a'); % Read the audio file
n = length(wave); % Number of points
t = linspace(0,15,n);
% Plot raw sample time trace
plot(t,wave);
xlabel('time (sec)')
title('raw time trace')
pause;

% Fourier Transform
xf = fft(wave,n);
% Magnitude of complex spectrum
modxf=sqrt(xf.*conj(xf));
% Define frequency axis
f = 1/15*(0:(n-1)/2 - 1); % The definition is different for odd and even number of points
% Plot on log scale the raw sample spectrum
semilogy(f,modxf(1:(n-1)/2))
title('raw spectrum')
xlabel('freq (Hz)')
pause;

% Filter out the frequencies that <0.2 percent of max amplitude frequency
filt = (0.2)/100;
[maxamp, index] = max(modxf(1:(n-1)/2));
xf(modxf < filt*maxamp) = 10^-10; % Filter out the least dominant frequencies
% Magnitude of filtered sample spectrum
newmodxf=sqrt(xf.*conj(xf));
% Plot on log scale the filtered sample spectrum
semilogy(f,newmodxf(1:(n-1)/2))
title('Filtered spectrum')
xlabel('freq (Hz)')
pause;

% Inverse fft
yt = ifft(xf);
% Plot the filtered sample time trace
plot(t,real(yt))
title('inverse fft of Filtered spectrum')
xlabel('time (sec)')
% Play the sound of the filtered sample
Fs = n/15; % Sampling rate
sound(real(yt),Fs)