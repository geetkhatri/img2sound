# Image to Sound

Maps an image to a spectrogram and generates an audio file from the spectrogram.

To convert an image to audio:
1. Run `img2sound.m`.
2. Provide the path to the image when prompted.

The generated audio file (WAV) will be saved in the same directory as the image.

### How it works

The script:
1. Takes an image as input
2. Converts the image to grayscale (if it's RGB)
3. Resizes the image to a fixed height
4. (Optional) Applies edge detection to the image so that the audio is more tone-like
5. Converts the image to double
6. Scales the pixel intensities to control the loudness of the audio
7. Maps the pixel intensities of the image to the power spectral densities of the spectrogram
8. Randomizes the phase spectrum of the STFT
9. Computes the inverse STFT
10. Plots the spectrogram
11. Generates an audio file

### Parameters

The parameters can be tweaked to get different types of sound.
- `fs`: adjusts the frequency range of the audio
- `M`, `H`: adjust the frequency/time resolution of the STFT
- `scaling_factor`: adjusts the loudness of the audio
- `edge_detection`: if true, the sound is more tone-like; if false, the sound is more noise-like

### Dependencies

The script has been tested with GNU Octave 4.4.1. The following packages are required:

| Package       | Version       |
| ------------- | ------------- |
| image         | 2.12.0        |
| signal        | 1.4.1         |
