# Industrial Machine Vibration Analysis Using Digital Signal Processing

## Overview

This project demonstrates how Digital Signal Processing (DSP) techniques can be applied to analyse machine vibration signals and identify spectral differences between illustrative healthy and faulty conditions.

The project uses MATLAB to generate synthetic vibration signals, introduce noise, apply a moving-average filter, and analyse the signals using the Fast Fourier Transform (FFT).

**Note:** This is a simulation-based academic project. The signals are synthetically generated; no real industrial machine was recorded or tested.

## Objectives

- Generate synthetic healthy and faulty vibration signals.
- Introduce Gaussian noise to simulate measurement noise.
- Apply a moving-average filter to smooth the signals.
- Analyse frequency components using FFT.
- Compare RMS values and spectral energy in a selected frequency band.
- Understand the role of DSP in vibration monitoring and condition analysis.

## Methodology

The project follows these main steps:

1. Generate synthetic vibration signals.
2. Add white Gaussian noise.
3. Apply a moving-average filter.
4. Calculate single-sided FFT amplitude spectra.
5. Compare time-domain waveforms and frequency-domain spectra.
6. Evaluate RMS values and spectral energy in the 150–220 Hz band.

## Tools and Technologies

- MATLAB
- Digital Signal Processing
- Fast Fourier Transform (FFT)
- Moving-Average Filtering
- Spectral Analysis

## Repository Contents

| File | Description |
|---|---|
| `main.tex` | LaTeX source file for the research paper |
| `fig_time.pdf` | Time-domain signal comparison figure |
| `fig_fft.pdf` | FFT spectrum figure |
| `fig_cmp.pdf` | Comparative analysis figure |
| `DSP_.zip` | Original Overleaf source archive |
| `Industrial_Machine_Vibration...` | Supporting document |
| `Vibration_DSP_Revised_Paper...` | Revised research paper document |

## Results

The simulation compares healthy and faulty synthetic vibration signals using spectral analysis.

In the reported MATLAB run, the filtered faulty signal exhibited greater spectral energy in the 150–220 Hz band than the filtered healthy signal.

These results demonstrate how frequency-domain analysis can reveal differences between synthetic signals. They do not establish the performance of a real industrial fault-detection system.

## Limitations

- Only synthetic vibration signals are used.
- No real industrial machine measurements are included.
- The project does not implement an automatic fault classifier.
- The results are not a validation of a real-time monitoring system.

## Academic Purpose

This repository contains the source files and supporting figures for an undergraduate academic project on industrial machine vibration analysis using DSP techniques.

## Author

**Puli Pragnan**  
Department of Electronics and Communication Engineering  
Chaitanya Bharathi Institute of Technology (CBIT), Hyderabad, India

## License

This repository is intended for academic and educational purposes.
