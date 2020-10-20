function delayfunc(t, f)
    % In the two lines of code below, provide any additional property value necessary to point the object to your sound card(s)
    DEF_RATE = 44100;
    DELAY_TIME = t; % (ms)
    DELAY_RATE = DELAY_TIME / 1000 * DEF_RATE;
    if DELAY_TIME == 0
        deviceReader = audioDeviceReader;
    else
        deviceReader = audioDeviceReader('SamplesPerFrame', DELAY_RATE);
    end
    deviceWriter = audioDeviceWriter;
    % 出力音声ファイル名(wavoutのフォルダの中)
    out = strcat('./wavout/',f);
    afw = dsp.AudioFileWriter(out, 'SampleRate',deviceReader.SampleRate);
    if ~exist('./wavout/', 'dir')
        mkdir('./wavout/')
    end
%     fprintf('Latency due to device buffer: %f seconds.\n',deviceReader.SamplesPerFrame/deviceReader.SampleRate)

    disp('Begin Signal Input...')
    tic
    while toc < 6
        mySignal = deviceReader();
        deviceWriter(mySignal);
        afw(mySignal); %音声ファイル書き込み
    end

    disp('End Signal Input')
    release(deviceReader)
    release(deviceWriter)
    release(afw)