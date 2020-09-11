clear all
filename = './wavout/NH-uramori-02.wav';
[y, Fs] = audioread(filename);
% plot(y)
% T = 1/Fs;
S = size(y);
L = S(1);
% t = (0:L-1)*T;

plot(y)

fileID = fopen('test.txt', 'w');
fprintf(fileID, '%6s %12s\r\n', 'n', 'time(ms)');

MAX = 20;
S = 2.5e4;
E = L - 1000;
sp = StartPoint(S, y, E);
ep = EndPoint(sp + MAX, y, E);
i = 1;
fprintf(fileID, '%6d %12d\r\n', i, (ep-sp));
disp(i)
disp(sp)
disp(ep)
disp(ep-sp)

while(ep < E || sp < E)
    sp = StartPoint(ep + MAX, y, E);
    ep = EndPoint(sp + MAX, y, E);
    if (ep - sp) > 1000
        i = i + 1;
        fprintf(fileID, '%6d %12d\r\n', i, (ep-sp));
        disp(i)
        disp(sp)
        disp(ep)
        disp(ep-sp)
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
        if D > 0.013 | (head+MAX) > E
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
        if D < 0.004 | (head+MAX) > E
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