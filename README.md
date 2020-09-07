# Image to Sound

Maps an image to a spectrogram and generates an audio file from the spectrogram.

The script:
1. Takes an image as input
2. Converts it to grayscale (if it's RGB)
3. Resizes it so that it can be mapped to the spectrogram
4. Adjusts the pixel intensities to control the loudness of the audio
5. (Optional) Applies edge detection to the image so that the audio is more tone-like
6. Maps the pixel intensities of the image to the power spectral densities of the spectrogram
7. Randomizes the phase spectrum
8. Computes the inverse STFT
9. Plots the spectrogram
10. Generates an audio file

### Parameters

The parameters can be tweaked to get different types of sound.
- `fs` (Sampling frequency): adjusts the frequency range of the audio
- `M`, `H`: adjust frequency/time resolution of the STFT
- `scaling_factor`: adjusts the volume of the audio
- `edge_detection`: if true, the sound is more tone-like; if false, the sound is more noise-like
