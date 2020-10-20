clear all;
delaytimes = [0;50;100;200];
subject = 'MI';
word = '00koutatu';
f1 = strcat(subject,'-',word,'-','0','.wav');
f2 = strcat(subject,'-',word,'-','1','.wav');
f3 = strcat(subject,'-',word,'-','2','.wav');
f4 = strcat(subject,'-',word,'-','3','.wav');
filenames = [f1;f2;f3;f4];

combi = [delaytimes, filenames];
[row, col] = size(combi);
temp = randperm(row);

randcombi = combi(temp,:);

%%
% random
for c = 1:length(randcombi)-1
    pause(1)
    disp(' ')
    disp('waitting......')
    delayfunc(randcombi(c,1), randcombi(c,2:col));
end

%%
% order
% for c = 1:length(combi)
%     pause(1)
%     disp(' ')
%     disp('waitting......')
%     delayfunc(combi(c,1), combi(c,2:col));
% end