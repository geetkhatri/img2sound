% Description: 
% Image to Sound maps an image to a spectrogram and 
% generates an audio file (WAV) from the spectrogram.
%
% Usage:
% Run the script. Provide the path to the image when prompted.
% The generated audio file will be saved in the same directory as the image.
%
% Author:
% Geet Khatri
% https://github.com/geetkhatri/

pkg load image
pkg load signal

% audio parameters
fs = 32000;                         % sampling frequency
frame_duration = 0.064;             % frame duration in seconds
M = frame_duration * fs;            % window size
overlap = 0.875;                    % overlap between adjacent frames
H = (1 - overlap) * M;              % hop size

% image parameters
height = M/2 + 1;                   % image height
edge_detection = true;              % use edge detection?
scaling_factor = 10;                % adjust loudness of output

% read image
img_path = input('Filename: ', 's');
while exist(img_path, 'file') ~= 2
    img_path = input('File does not exist. Try again: ', 's');
end
img = imread(img_path);

% convert to grayscale
if size(img, 3) == 3
  img = rgb2gray(img);
end

% resize
img = imresize(img, [height, NaN]);

% edge detection
if edge_detection
    [~, threshold] = edge(img,'sobel');
    fudgeFactor = 0.7;
    img = edge(img, 'sobel', threshold * fudgeFactor);
    imshow(img)
end

% convert to double, flip upside down and scale
img_double = scaling_factor * flipud(im2double(img));

% audio synthesis
nframes = size(img_double, 2);  % number of frames in STFT
leny = M + (nframes - 1) * H;   % length of reconstructed signal
y = zeros(leny, 1);             % initialise reconstructed signal
w = hamming(M, 'periodic');     % window
X = zeros(M, nframes);          % initialise STFT
offy = M/2;                     % initialise offset in y
for i = 1 : nframes
    samples = offy - M/2 + 1 : offy + M/2;                    % samples of y to be reconstructed
    phase = 2 * pi * (rand(M/2 + 1, 1) - 0.5);                % randomize phase
    X(1 : M/2 + 1, i) = img_double(:, i) .* exp(1j * phase);  % apply randomized phase
    X(M/2 + 2 : M, i) = conj(flipud(X(2 : M/2, i)));          % remaining values of FFT
    yfw = ifft(X(:, i)) .* w;                                 % inverse FFT
    y(samples) = y(samples) + yfw;                            % overlap add
    offy = offy + H;                                          % offset for next iteration of loop
end
y = real(y);       % ignore imaginary parts that arise due to floating point imprecision

% plot spectrogram
figure;
specgram(y, M, fs, w, M - H);
xlabel('Time (s)')
ylabel('Frequency (Hz)')

% write audio file
audio_path = strjoin({strsplit(img_path, '.'){1}, '- img2sound.wav'});
audiowrite(audio_path, y, fs);