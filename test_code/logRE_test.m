%% This is the matlab code to log data from the rotary encoder
% create by Zilong Ji (2023) zilong.ji@ucl.ac.uk
clear; clc;


% % display a message to prompt user to press 'g' key
% disp('Press ''g'' to continue...');
% 
% while true
%     % Wait for a button press
%     w = waitforbuttonpress;
%     
%     % Check if the pressed key is "g"
%     if strcmp(get(gcf, 'CurrentCharacter'), 'g')
%         % Execute your code here
%         disp('g key pressed');
%         break; % exit the loop
%     end
% end

%1, Open COM port:
E2019Q_ID = E2019Q.Open_COM_Port('COM4');

%2, Set current count value to zero:
E2019Q.ResetCurrentCount(E2019Q_ID);

%3, Generate filename with timestamp
timestamp = datestr(now, 'yyyymmdd_HHMMSS');
filename = ['./Logs/REdata_', timestamp, '.txt'];

% Open file for writing
fid = fopen(filename, 'w');

% Write data with timestamp to file
count=0;

while count<2000
    % Read encoder count in double precision format
    Enc_count = E2019Q.GetEncCountDOUBLE(E2019Q_ID);
    
    %change the Enc_count to radians
    Enc_count = mod(Enc_count/36800*2*pi, 2*pi);
    Enc_count = Enc_count*180/pi;

    %TimeStamp = datestr(datetime('now'), 'yyyy-mm-dd HH:MM:SS.FFF');
    TimeStamp = datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss.SSS');
    
    % Write data and timestamp to file
    fprintf(fid, '%s Rot=%f\n', TimeStamp, Enc_count);
    
    count = count+1;

end

% Close file
fclose(fid);

%End, Close COM port:
%instrfind
%delete(instrfind({'Port'},{'COM4'}));
E2019Q.Close_COM_Port(E2019Q_ID);