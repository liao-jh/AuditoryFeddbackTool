clear all
fol = dir('./wavout/delaytime10-7-1/*.wav');
n = size(fol,1);
fileID = fopen('./output/delaytime1.txt','w');

% filename = fol(3).name;
% read = strcat('./wavout/delaytime10-7-1/', filename);
% [y, fs] = audioread(read);
% size(y)
% subplot(2,1,1)
% plot(y(:, 1))
% subplot(2,1,2)
% plot(y(:, 2))

    fprintf(fileID, '\n%20s %20s %20s %20s\n', 'filename', 'time', 'sp1', 'sp2');
for i = 1:n
    file = fol(i).name;
    leghtwriter(file, fileID);
end


function leghtwriter(file, fileID)
    filename = strcat('./wavout/delaytime10-7-1/', file);
    [y, Fs] = audioread(filename);
    S = size(y);
    L = S(1);

    S = 1e4;
    E = L - 1000;
    sp1 = StartPoint(S, y(:, 1), E);
    sp2 = StartPoint(S, y(:, 2), E);
    fprintf(fileID, '%20s %20f %20f %20f\n', file, (sp2-sp1)/Fs*1000, sp1/Fs*1000, sp2/Fs*1000);

end


function sp = StartPoint(head, y, E)
    MAX = 100;
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
        if D > 0.01 | (head+MAX) > E
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