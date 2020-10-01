clear all

fol = dir('./wavout/*.wav');
n = size(fol,1);
for i = 1:n
    filename = fol(i).name;
    read = strcat('./wavout/', filename);
    [f, fs] = audioread(read);
    N = size(f,1);

    n = 7;
    beginFreq = 500 / (fs/2);
    endFreq = 15000 / (fs/2);
    [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');

    fOut = filter(b, a, f);
    save = strcat('./wavout/filter/', filename);
    audiowrite(save, fOut, fs);
end
% filename = fol(20).name;
% disp(filename)
% read = strcat('./wavout/', filename);
% [f, fs] = audioread(read);
% subplot(2,1,1)
% plot(f)
% N = size(f,1);
% 
% n = 7;
% beginFreq = 500 / (fs/2);
% endFreq = 15000 / (fs/2);
% [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
% 
% fOut = filter(b, a, f);
% save = strcat('./wavout/filter/', filename);
% audiowrite(save, fOut, fs);
% subplot(2,1,2)
% plot(fOut)