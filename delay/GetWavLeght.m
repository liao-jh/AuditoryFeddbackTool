clear all
% filename = 'NH-runnbasu-2.wav';
% read = strcat('./filter/', filename);
% fol = dir('./wavout/*.wav');
fol = dir('./filter/*.wav');
n = size(fol,1);
fileID = fopen('./output/exp5.txt','w');

% filename = fol(13).name;
% read = strcat('./filter/', filename);
% fprintf(fileID, '%20s %20s %20s %20s\n', read, 'sp', 'ep', 'time');
% leghtwriter(read, fileID);

for i = 1:n
    filename = fol(i).name;
    fprintf(fileID, '\n%20s %20s %20s %20s\n', filename, 'sp', 'ep', 'time');
    read = strcat('./filter/', filename);
    leghtwriter(read, fileID);
end


% fprintf(fileID, '%20s %20s %20s %20s\n', filename, 'sp', 'ep', 'time');
% leghtwriter(read, fileID);


function leghtwriter(filename, fileID)
    [y, Fs] = audioread(filename);
    % T = 1/Fs;
    S = size(y);
    L = S(1);
    % t = (0:L-1)*T;

%     plot(y)

    MAX = 20;
    S = 2e4;
    E = L - 1000;
    sp = StartPoint(S, y, E);
    ep = EndPoint(sp + MAX, y, E);
    i = 1;
    fprintf(fileID, '%20d %20f %20f %20f\n', i, sp/Fs*1000, ep/Fs*1000, (ep-sp)/Fs*1000);
    % disp(i)
    % disp(sp/Fs)
    % disp(ep/Fs)
    % disp((ep-sp)/Fs)
%     disp(i)
%     disp(sp)
%     disp(ep)
%     disp(ep-sp)
    while(ep < E || sp < E)
        sp = StartPoint(ep + MAX, y, E);
        ep = EndPoint(sp + MAX, y, E);
        if (ep - sp) > 1000
            i = i + 1;
            fprintf(fileID, '%20d %20f %20f %20f\n', i, sp/Fs*1000, ep/Fs*1000, (ep-sp)/Fs*1000);
    %         disp(i)
    %         disp(sp/Fs)
    %         disp(ep/Fs)
    %         disp((ep-sp)/Fs)        
%             disp(i)
%             disp(sp)
%             disp(ep)
%             disp(ep-sp)
        end
    end
end
function sp = StartPoint(head, y, E)
    MAX = 50;
    F = zeros(1, MAX);
    c = 1;
    for i = head : head + (MAX - 1)
        F(c) = y(i);
        c = c + 1;
    end
    D = zeros(1, MAX/2);
    for i = 1:MAX/2
        D(i) = F(MAX-(i-1)) - F(i);
        D = abs(D);
    end
    while(true)
        if D > 0.001 | (head+MAX) > E
            break;
        else
            head = head + 1;
            for i = 1:(MAX - 1)
                F(i) = F(i + 1);
            end
            F(MAX) = y(head);
            for i = 1:MAX/2
                D(i) = F(MAX-(i-1)) - F(i);
                D = abs(D);
            end
        end
    end
%     disp(D)
    sp = head;
end
function ep = EndPoint(head, y, E)
    MAX = 80;
    F = zeros(1, MAX);
    c = 1;
    for i = head - (MAX - 1):head
        F(c) = y(i);
        c = c + 1;
    end
    D = zeros(1, MAX/2);
    for i = 1:MAX/2
        D(i) = F(MAX-(i-1)) - F(i);
        D = abs(D);
    end
    while(true)
        if D < 0.001 | (head+MAX) > E
            break;
        else
            head = head + 1;
            for i = 1:(MAX - 1)
                F(i) = F(i + 1);
            end
            F(MAX) = y(head - (MAX - 1));
            for i = 1:MAX/2
                D(i) = F(MAX-(i-1)) - F(i);
                D = abs(D);
            end
        end
    end
%     disp(D)
    ep = head;
end