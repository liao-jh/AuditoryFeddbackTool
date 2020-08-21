function RealTimeFeedback(deviceReader, deviceWriter, filename, pitch, overlap)
    %音声ファイル書き込み
    afw = dsp.AudioFileWriter(filename, 'SampleRate',deviceReader.SampleRate);
    
    tic
    while toc < 5
        mySignal = deviceReader();
        pitchShifted = zeros(size(double(mySignal)),'like',double(mySignal)); %#ok<PREALL>
        pitchShifter.PitchShift = pitch;
        pitchShifter.Overlap = overlap;
        [pitchShifted] = pitchShifter(double(mySignal));
        deviceWriter(pitchShifted);%ピッチシフトフィードバック
        afw(mySignal); %音声ファイル書き込み
    end
    
    release(afw)
end