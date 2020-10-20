function sinwaveshift(semitone, F0)
    fs = 44100;
    t = [0:1/fs:5];
    f = F0*2^(semitone/12);
    y = sin(2*pi*f*t); 
    audiowrite('./wavout/pure_shift.wav',y,fs)
    %soundsc(y,fs);
    %plot(t,y);
    %axis([0 0.01 -1 1]);
end
