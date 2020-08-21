function recordmyvoice
    deviceReader = audioDeviceReader;
    deviceWriter = audioDeviceWriter('SampleRate',deviceReader.SampleRate);
    %音声ファイル書き込み
    afw = dsp.AudioFileWriter('./wavout/myvoice.wav', 'SampleRate',deviceReader.SampleRate);
    CountDown();
    
    tic
    while toc < 5
        mySignal = deviceReader();
        afw(mySignal);
    end
    
    disp('End record')
    
    release(afw)
    release(deviceReader)
    release(deviceWriter)
end