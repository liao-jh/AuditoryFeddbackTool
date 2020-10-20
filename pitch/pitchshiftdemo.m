
% In the two lines of code below, provide any additional property value necessary to point the object to your sound card(s)
deviceReader = audioDeviceReader;
deviceWriter = audioDeviceWriter('SampleRate',deviceReader.SampleRate);
%scope = dsp.TimeScope;

%出力音声ファイル名(wavoutのフォルダの中)
afw = dsp.AudioFileWriter('./wavout/test.wav', 'SampleRate',deviceReader.SampleRate);

pitch = 0; %値の分半音シフトする
overlap = 0.2;
%sinwaveshift(pitch); %純音の生成
%fileReader = dsp.AudioFileReader('./wavout/c3_shift.wav'); %純音の音声ファイル
Fs = 8192;
pitchShifter = audiopluginexample.PitchShifter('PitchShift',8,'Overlap',0.3);
setSampleRate(pitchShifter,Fs);
disp('Begin Signal Input...')
tic
while toc < 5
    mySignal = deviceReader();
    %signal = fileReader();
    % Process mySignal as needed
    %audioout = shiftPitch(mySignal, 5);
    %audioout = stretchAudio(mySignal, 1.5);
    pitchShifted = zeros(size(double(mySignal)),'like',double(mySignal)); %#ok<PREALL>
    pitchShifter.PitchShift = pitch;
    pitchShifter.Overlap = overlap;
    [pitchShifted] = pitchShifter(double(mySignal));
    %[pitchShifted] = pitchShifter(double(signal));
    %deviceWriter(mySignal); %自分の声をそのままフィードバック
    deviceWriter(pitchShifted);%ピッチシフトフィードバック
    %deviceWriter(signal); %純音をフィードバック
    %deviceWriter([pitchShifted, mySignal]); 
    afw(mySignal); %音声ファイル書き込み
    %scope(mySignal); 
    
end
disp('End Signal Input')
release(deviceReader)
release(deviceWriter)
release(afw)