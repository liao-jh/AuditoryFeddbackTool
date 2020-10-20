function recordfunc(f)
    deviceReader = audioDeviceReader;
    deviceWriter = audioDeviceWriter;
    % 出力音声ファイル名(wavoutのフォルダの中)
    out = strcat('./wavout/',f);
    afw = dsp.AudioFileWriter(out, 'SampleRate',deviceReader.SampleRate);
    if ~exist('./wavout/', 'dir')
        mkdir('./wavout/')
    end
    
    disp('Begin Signal Input...')
    disp(out)
    
    tic
    while toc < 1
        mySignal = deviceReader();
        deviceWriter(mySignal);
        afw(mySignal); %音声ファイル書き込み
    end

    disp('End Signal Input')
    release(deviceReader)
    release(deviceWriter)
    release(afw)