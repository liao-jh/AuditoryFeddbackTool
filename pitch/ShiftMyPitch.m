function ShiftMyPitch(nsemitones)
    [audioIn, fs] = audioread('./wavout/myvoice.wav');
    audioOut = shiftPitch(audioIn, nsemitones);
    audiowrite('./wavout/myvoice_shift.wav', audioOut, fs);
    %filename = append('./wavout/mysound_shitf', int2str(nsemitones), '.wav');
    %audiowrite(filename, audioOut, fs);
end
    