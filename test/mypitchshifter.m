
pitch = 3; %この値の分半音シフトする

% In the two lines of code below, provide any additional property value necessary to point the object to your sound card(s)
deviceReader = audioDeviceReader;
deviceWriter = audioDeviceWriter('SampleRate',deviceReader.SampleRate);
%音声ファイル書き込み
filename = append('./wavout/Withfeedback', int2str(pitch), '.wav');
afw = dsp.AudioFileWriter(filename, 'SampleRate',deviceReader.SampleRate);

prompt = '[1:pure][2:record][3:realtime]';
x = input(prompt);

overlap = 0.2;
Fs = 8192;
pitchShifter = audiopluginexample.PitchShifter('PitchShift',8,'Overlap',0.3);
setSampleRate(pitchShifter,Fs);

switch x
    case 1
        disp('Recording your sound and make pure tone')
        recordmyvoice();
        F0 = GetMyF0('./wavout/myvoice.wav');
        sinwaveshift(pitch, F0);
        %純音の音声ファイル
        fileReader = dsp.AudioFileReader('./wavout/pure_shift.wav');
        disp('Begin feedback...')
        CountDown();
        tic
        while toc < 5
            mySignal = deviceReader();
            signal = fileReader();
            deviceWriter(signal); %純音をフィードバック
            afw(mySignal);
        end
        disp('End record with feedback')
        worlddio('puretone', './wavout/myvoice.wav', './wavout/pure_shift.wav', filename, 'myvoice', 'puretoneshift', 'withfeedback', F0);
        
    case 2
        disp('Recording your sound and return that')
        
        recordmyvoice();
        F0 = GetMyF0('./wavout/myvoice.wav');
        ShiftMyPitch(pitch);
        %純音の音声ファイル
        fileReader = dsp.AudioFileReader('./wavout/myvoice_shift.wav');
        disp('Begin feedback...')
        CountDown();
        tic
        while toc < 5
            mySignal = deviceReader();
            signal = fileReader();
            deviceWriter(signal); %自分のピッチシフト音声をフィードバック
            afw(mySignal);
        end
        disp('End record with feedback')
        worlddio('myvoice', './wavout/myvoice.wav', './wavout/myvoice_shift.wav', filename, 'myvoice', 'myvoiceshift', 'withfeedback', F0);
        
    case 3
        disp('Return your sound realtime')
        %disp('This will do twice')
       
        %disp('Begin feedback frist time...')
        %CountDown();
        %RealTimeFeedback(deviceReader, deviceWriter, './wavout/realtime_pitchshift1.wav', pitch, overlap);
        %F0 = GetMyF0('./wavout/realtime_pitchshift1.wav');
        %pause(1)
        
        %disp('Begin feedback second time...')
        %CountDown();
        %RealTimeFeedback(deviceReader, deviceWriter, './wavout/realtime_pitchshift2.wav', pitch, overlap);
        CountDown();
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
        pause(1)
        disp('End record with feedback')
        F0 = GetMyF0(filename);
        [y,fs] = audioread(filename);
        r = Dio(y, fs);
        plot(r.temporal_positions, r.f0,'LineWidth',1)
        title('realtime')
        ylim([F0-50 F0+10])
        xlim([0 5])
        xlabel('Time [s]'); ylabel('F0 [Hz]')
        %worlddio('realtime', './wavout/myvoice.wav', './wavout/realtime_pitchshift1.wav', './wavout/realtime_pitchshift2.wav', 'myvoice', 'feedback1', 'feedback2', F0);
        
    otherwise
        disp('Unknow input')
end


disp('End Signal Input')
release(deviceReader)
release(deviceWriter)
release(afw)