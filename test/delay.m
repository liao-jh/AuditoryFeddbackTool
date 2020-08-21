%%
% In the two lines of code below, provide any additional property value necessary to point the object to your sound card(s)
deviceReader = audioDeviceReader;
deviceWriter = audioDeviceWriter('SampleRate',deviceReader.SampleRate);
% scope = dsp.TimeScope;

% 出力音声ファイル名(wavoutのフォルダの中)
afw = dsp.AudioFileWriter('./wavout/test.wav', 'SampleRate',deviceReader.SampleRate);
if ~exist('./wavout/', 'dir')
    mkdir('./wavout/')
end

pitch = 0; % 値の分半音シフトする
shiftime = 0;
overlap = 0.2;
Fs = 8192;
% pitchShifter = audiopluginexample.PitchShifter('PitchShift',8,'Overlap',0.3);
flanger = audiopluginexample.Flanger;
setSampleRate(flanger,deviceReader.SampleRate);
%parameterTuner(flanger)

%%

disp('Begin Signal Input...')
tic
while toc < 5
    mySignal = deviceReader();
    delaySignal = zeros(size(double(mySignal)),'like',double(mySignal)); %#ok<PREALL>
    [delaySignal] = flanger.Flanger;
    deviceWriter(delaySignal);
    afw(mySignal); %音声ファイル書き込み
    %scope(mySignal); 
end

%%
disp('End Signal Input')
release(deviceReader)
release(deviceWriter)
release(afw)