# Image to Sound

_Image to Sound_ maps an image to a spectrogram and generates an audio file from the spectrogram.

To convert an image to audio:
1. Run `img2sound.m`.
2. Provide the path to the image when prompted.

The generated audio file (WAV) will be saved in the same directory as the image.

### How it works

The script:
1. Converts the image to grayscale (if it's RGB)
2. Resizes the image to a fixed height
3. (Optional) Applies edge detection to the image so that the audio is more tone-like
4. Scales the pixel intensities of the image to control the loudness of the audio
5. Maps the pixel intensities to the power spectral densities of the spectrogram
6. Randomizes the phase spectrum of the STFT
7. Computes the inverse STFT to produce samples of the audio
8. Plots the spectrogram
9. Generates an audio file from the samples

### Parameters

The parameters can be tweaked to get different types of sound.
- `fs` (sampling frequency): adjusts the frequency range of the audio
- `M` (FFT/window size), `H` (hope size): adjust the frequency/time resolution of the STFT and duration of the audio
- `scaling_factor`: adjusts the loudness of the audio
- `edge_detection`: if true, the sound is more tone-like; if false, the sound is more noise-like

### Dependencies

The script has been tested with GNU Octave 4.4.1. The following packages are required:

| Package       | Version       |
| ------------- | ------------- |
| image         | 2.12.0        |
| signal        | 1.4.1         |
