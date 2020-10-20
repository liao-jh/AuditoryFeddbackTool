clear all


delaytime = '200';
subject = 'LJ';

ds = readtable('TestWord.xlsx');

[row,col] = size(ds);
temp = randperm(col);
randds = sortrows(ds,temp);

randfile = strcat('randomword1-',subject,'.txt');
writetable(randds,randfile,'Delimiter',' ') 


%%
%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[0,0,1440,900]);

htext  = uicontrol('Style','text','String','キーを押して実験開始','FontSize',100,'FontWeight','bold','units','normalized','OuterPosition',[0,0,1,0.65]);

align(htext,'Center','None');
f.Visible = 'on';

waitforbuttonpress;
htext.String = 'Watting...';
drawnow

for c = 1:row

    word = randds.(2){c};
    outfile = strcat(subject,'-',word,'-',delaytime,'.wav');
    pause(1)
    
    htext.String = word;
    drawnow
    recordfunc(outfile);
    
    if c == 10
        htext.String = '休憩時間です';
        drawnow
        waitforbuttonpress;
    end
    
    htext.String = 'Watting...';
    drawnow
end

htext.String = '休憩時間です';
drawnow
w = waitforbuttonpress;

temp = randperm(col);
randds = sortrows(ds,temp);

randfile = strcat('randomword2-',subject,'.txt');
writetable(randds,randfile,'Delimiter',' ') 

for c = 1:row
    
    word = randds.(5){c};
    outfile = strcat(subject,'-',word,'-',delaytime,'.wav');
    pause(1)
    
    htext.String = word;
    drawnow
    recordfunc(outfile);    
        
    if c == 10
        htext.String = '休憩時間です';
        drawnow
        waitforbuttonpress;
    end
    
    htext.String = 'Watting...';
    drawnow
    
end

htext.String = '実験終了です\nお疲れさまでした';
drawnow
%%
