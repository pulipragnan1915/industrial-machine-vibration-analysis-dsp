% Industrial Machine Vibration Monitoring and Early Fault Detection Using DSP
% Academic demonstration with SYNTHETIC vibration signals (not real machine data).
% Shows vibration waveforms and FFT spectra before/after simple smoothing.

clc; clear; close all;
rng(7);                         % Reproducible random noise

%% 1. Generate synthetic vibration signals
fs = 2000;                      % Sampling frequency (Hz)
T = 2;                          % Duration (seconds)
t = 0:1/fs:T-1/fs;
N = length(t);

% Healthy machine: fundamental vibration and harmonic
healthy_clean = sin(2*pi*30*t) + 0.30*sin(2*pi*60*t);

% Faulty machine: add illustrative fault-related frequency components
faulty_clean = healthy_clean + 0.55*sin(2*pi*180*t) ...
                            + 0.30*sin(2*pi*300*t);

% Add random noise
noise_level = 0.65;
healthy_noisy = healthy_clean + noise_level*randn(size(t));
faulty_noisy  = faulty_clean  + noise_level*randn(size(t));

%% 2. Reduce some rapid fluctuations using a moving-average filter
% Note: smoothing can also weaken high-frequency fault information.
windowLength = 5;
kernel = ones(1, windowLength)/windowLength;
healthy_filtered = conv(healthy_noisy, kernel, 'same');
faulty_filtered  = conv(faulty_noisy, kernel, 'same');

%% 3. Plot signals before and after smoothing
showN = min(N, round(0.25*fs));
figure('Name','Vibration Before and After Filtering','Color','w');

subplot(2,2,1);
plot(t(1:showN), healthy_noisy(1:showN));
title('Healthy: before filtering'); xlabel('Time (s)');
ylabel('Amplitude'); grid on;

subplot(2,2,2);
plot(t(1:showN), healthy_filtered(1:showN));
title('Healthy: after smoothing'); xlabel('Time (s)');
ylabel('Amplitude'); grid on;

subplot(2,2,3);
plot(t(1:showN), faulty_noisy(1:showN));
title('Faulty: before filtering'); xlabel('Time (s)');
ylabel('Amplitude'); grid on;

subplot(2,2,4);
plot(t(1:showN), faulty_filtered(1:showN));
title('Faulty: after smoothing'); xlabel('Time (s)');
ylabel('Amplitude'); grid on;

%% 4. Calculate single-sided FFT spectra
[f, H_noisy] = singleSidedFFT(healthy_noisy, fs);
[~, H_filtered] = singleSidedFFT(healthy_filtered, fs);
[~, F_noisy] = singleSidedFFT(faulty_noisy, fs);
[~, F_filtered] = singleSidedFFT(faulty_filtered, fs);

figure('Name','FFT Before and After Filtering','Color','w');
subplot(2,1,1);
plot(f,H_noisy,'DisplayName','Before'); hold on;
plot(f,H_filtered,'DisplayName','After');
xlim([0 500]); title('Healthy vibration spectrum');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
legend('Location','northeast'); grid on;

subplot(2,1,2);
plot(f,F_noisy,'DisplayName','Before'); hold on;
plot(f,F_filtered,'DisplayName','After');
xlim([0 500]); title('Faulty vibration spectrum');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
legend('Location','northeast'); grid on;

%% 5. Compare healthy and faulty spectra after filtering
figure('Name','Healthy vs Faulty Spectrum','Color','w');
plot(f,H_filtered,'DisplayName','Healthy (filtered)'); hold on;
plot(f,F_filtered,'DisplayName','Faulty (filtered)');
xlim([0 500]); title('Healthy vs faulty vibration');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
legend('Location','northeast'); grid on;

%% 6. Simple feature comparison
% The 150-220 Hz band is illustrative because the synthetic fault includes
% a 180 Hz component. For real data, choose features from the machine.
band = (f >= 150 & f <= 220);
healthyRMS = sqrt(mean(healthy_filtered.^2));
faultyRMS = sqrt(mean(faulty_filtered.^2));
healthyBandEnergy = sum(H_filtered(band).^2);
faultyBandEnergy = sum(F_filtered(band).^2);

fprintf('\n--- Synthetic demonstration results ---\n');
fprintf('Healthy filtered RMS: %.4f\n', healthyRMS);
fprintf('Faulty filtered RMS : %.4f\n', faultyRMS);
fprintf('Healthy 150-220 Hz spectral energy: %.6f\n', healthyBandEnergy);
fprintf('Faulty 150-220 Hz spectral energy : %.6f\n', faultyBandEnergy);
fprintf('\nThese are synthetic examples, not real-machine results.\n');
fprintf('Moving-average smoothing may also weaken fault-related frequencies.\n');

%% Local function: single-sided FFT using base MATLAB
function [f, magnitude] = singleSidedFFT(x, fs)
    x = x(:).';
    N = length(x);
    X = fft(x);
    magnitude = abs(X/N);
    magnitude = magnitude(1:floor(N/2)+1);
    if length(magnitude) > 2
        magnitude(2:end-1) = 2*magnitude(2:end-1);
    end
    f = fs*(0:floor(N/2))/N;
end
