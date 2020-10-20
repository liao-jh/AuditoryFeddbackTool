function sinwave(F0)
    fs = 44100;
    t = [0:1/fs:5];
    f = F0;
    y = sin(2*pi*f*t); 
    audiowrite('pure.wav',y,fs)
    %soundsc(y,fs);
    %plot(t,y);
    %axis([0 0.01 -1 1]);
end