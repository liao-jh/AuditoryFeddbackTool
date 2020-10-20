[y,fs] = audioread('test_3.wav');
r = Dio(y, fs);
f = CheapTrick(y, fs, r);
S = log(f.spectrogram);
M = mean(S,2);
M2 = M.';
%t = (0:1024)*(fs/1025*2);
t = 0:(fs/2/size(f.spectrogram,1)):(fs/2)-1;
plot(t, M2)
%xlabel('freqency [Hz]'); ylabel('Power [dB]')
