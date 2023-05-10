%% This is the matlab code to log data from the rotary encoder
% This code is similar to logRE, which has sampling frequence around 200Hz
% It requires key pressing on the pop-out figure which does not work if
% you move the cursor and click somewhere else outside the window.

% create by Zilong Ji (2023) zilong.ji@ucl.ac.uk

% The log file looks like:

% 2023-05-10 15:23:44.772 Rot=99.136957
% 2023-05-10 15:23:44.778 Rot=99.136957
% 2023-05-10 15:23:44.785 Rot=99.136957
% 2023-05-10 15:23:44.790 Rot=99.136957
% 2023-05-10 15:23:44.796 Rot=99.136957
% 2023-05-10 15:23:44.802 Rot=99.136957
% 2023-05-10 15:23:44.806 Rot=99.136957
% 2023-05-10 15:23:44.809 Rot=99.136957

clear; clc;

%1, Open COM port:
E2019Q_ID = E2019Q.Open_COM_Port('COM4');

%2, Set current count value to zero:
E2019Q.ResetCurrentCount(E2019Q_ID);

%3, Generate filename with timestamp
timestamp = datestr(now, 'yyyymmdd_HHMMSS');
filename = ['./Logs/REdata_', timestamp, '.txt'];

% Open file for writing
fid = fopen(filename, 'w');

myFig = figure('KeyPressFcn', @myKeyPressFcn,'UserData', false);

% loop until a key is pressed to stop the while loop
while true
    % Read encoder count in double precision format
    Enc_count = E2019Q.GetEncCountDOUBLE(E2019Q_ID);
    
    %change the Enc_count to radians
    Enc_count = mod(Enc_count/36800*2*pi, 2*pi);
    Enc_count = Enc_count*180/pi;

    %TimeStamp = datestr(datetime('now'), 'yyyy-mm-dd HH:MM:SS.FFF');
    TimeStamp = datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss.SSS');
    
    % Write data and timestamp to file
    fprintf(fid, '%s Rot=%f\n', TimeStamp, Enc_count);
    
    if myFig.UserData
        close(myFig)
        break
    end
    
    drawnow
end

% Close file
fclose(fid);

%End, Close COM port:
%instrfind
%delete(instrfind({'Port'},{'COM4'}));
E2019Q.Close_COM_Port(E2019Q_ID);

function myKeyPressFcn(src, evt)
    if strcmp(evt.Key, 'b')
        src.UserData = true;
    end
end