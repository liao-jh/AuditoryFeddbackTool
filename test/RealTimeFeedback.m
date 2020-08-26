%% Init
pitch = 3; % この値の分半音シフトする

% In the two lines of code below, provide any additional property value necessary to point the object to your sound card(s)
deviceReader = audioDeviceReader;
deviceWriter = audioDeviceWriter('SampleRate',deviceReader.SampleRate);
%音声ファイル書き込み
% filename = append('./wavout/Withfeedback', int2str(pitch), '.wav');
% afw = dsp.AudioFileWriter(filename, 'SampleRate',deviceReader.SampleRate);
overlap = 0.2;
Fs = 8192;
pitchShifter = audiopluginexample.PitchShifter('PitchShift',8,'Overlap',0.3);
setSampleRate(pitchShifter,Fs);

%% Feedback original voice
disp('Start Feedback')
tic
while toc < 8
    mySignal = deviceReader();
    deviceWriter(mySignal);%ピッチシフトフィードバック
%     afw(mySignal); %音声ファイル書き込み
end

%% Feedback pitched voice
disp('Start Feedback')
tic
while toc < 8
    mySignal = deviceReader();
    pitchShifted = zeros(size(double(mySignal)),'like',double(mySignal)); %#ok<PREALL>
    pitchShifter.PitchShift = pitch;
    pitchShifter.Overlap = overlap;
    [pitchShifted] = pitchShifter(double(mySignal));
    deviceWriter(pitchShifted);%ピッチシフトフィードバック
%     afw(mySignal); %音声ファイル書き込み
end


%% End
disp('End Feedback')
% release(afw)