clear all
filename = './wavout/LJ-amagumo-0.wav';
fristsize = [29475, 35312];
[y, Fs] = audioread(filename, fristsize);
subplot(2,1,1)
x = y;
plot(x)

clear y Fs
secondsize = [30177, 43339];
[y, Fs] = audioread(filename, secondsize);
subplot(2,1,2)
plot(y)