function worlddio(name, file1, file2, file3, label1, label2, label3, F0)
    [y1,fs1] = audioread(file1);
    [y2,fs2] = audioread(file2);
    [y3,fs3] = audioread(file3);

    r1 = Dio(y1, fs1);
    r2 = Dio(y2, fs2);
    r3 = Dio(y3, fs3);
    plot(r1.temporal_positions, r1.f0,r2.temporal_positions, r2.f0,r3.temporal_positions, r3.f0,'LineWidth',1)
    title(name)
    ylim([F0-20 F0+20])
    xlabel('Time [s]'); ylabel('F0 [Hz]')
    legend(label1, label2, label3)
end