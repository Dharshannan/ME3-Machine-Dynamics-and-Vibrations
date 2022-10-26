wave = audioread('Piano.m4a'); % Read the audio file
n = length(wave); % Number of points
t = linspace(0,5,n); % (NOTE: n is even number of points)
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
f = 1/5*(0:n/2 - 1); % The definition is different for odd and even number of points
% Plot on log scale the raw sample spectrum
semilogy(f,modxf(1:n/2))
title('raw spectrum')
xlabel('freq (Hz)')
pause;

% Filter out frequencies between 500-15000 Hz. Pain in da arse mate :(
% F(Nq) is 24473.6 Hz, now we find the points that lie within this range,
% remember that at the F(Nq) the data is reflected, hence perform filter
% seperately for parts of the points that are lower and higher than the
% Nquist frequency, note there are 244736 points.

%f(2501) = 500Hz
%f(75001) = 15000Hz (filter between these indices)
df = 1/5;
L = 500/df;
U = 15000/df;
xf(L:U) = 10^-10; % Filter frequency before F(Nq)
xf((n/2 - U + n/2 + 1):(n/2 - L + n/2 + 1)) = 10^-10; % Filter frequency after F(Nq)

% Magnitude of filtered sample spectrum
newmodxf=sqrt(xf.*conj(xf));
% Plot on log scale the filtered sample spectrum
semilogy(f,newmodxf(1:n/2))
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
Fs = n/5; % Sampling rate
sound(real(yt),Fs)