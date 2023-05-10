%% This is the matlab code to read data from the rotary encoder
% create by Zilong Ji (2023) zilong.ji@ucl.ac.uk
clear; clc;
%1, Open COM port:
E2019Q_ID = E2019Q.Open_COM_Port('COM4');

%13. Clear reference status flag
E2019Q.ClearReferenceFlag(E2019Q_ID);

%15. Clear zero offset value stored by “ResetCurrentCount” function:
E2019Q.ClearZeroOffset(E2019Q_ID);

%3, Read E201-9Q software version
SW_Version = E2019Q.GetSoftwareVersion(E2019Q_ID);

%4, Read serial number
Serial_num = E2019Q.GetSerialNumber(E2019Q_ID);

%5. Read encoder supply status, voltage and current consumption:
Enc_supply = E2019Q.GetEncSupply(E2019Q_ID);

%6. Read status of hardware input pins on interface
Pin_Status = E2019Q.GetInputPinStatus(E2019Q_ID);

%7. Turn off power supply to encoder:
Power_supply = E2019Q.EncSupply_OFF(E2019Q_ID);

%8. Turn on power supply to encoder:
Power_supply = E2019Q.EncSupply_ON(E2019Q_ID);

%9. Read encoder position (string, decimal):
Enc_position = E2019Q.GetEncPosition(E2019Q_ID);

%10. Read encoder position (string, decimal) with position timestamp in µs
Enc_position = E2019Q.GetEncPosition_Timestamp(E2019Q_ID);


%14. Set current count value to zero:
E2019Q.ResetCurrentCount(E2019Q_ID)

Enc_position_reset = E2019Q.GetEncPosition_Timestamp(E2019Q_ID);

%18, Read timestamp of position in double precision format:
DoubelTimeStamp = E2019Q.GetTimestampDOUBLE(E2019Q_ID)/1000000;

%Convert to time
%refTime = datenum(DoubelTimeStamp);
%datestr(refTime,'yyyy-mm-dd HH:MM:SS.FFF')
d = datetime(DoubelTimeStamp,'ConvertFrom','epochtime','Format','dd-MM-yyyy HH:mm:ss.SSSSSSSSS');


%End, Close COM port:
%delete(instrfind({'Port'},{'COM4'}));
E2019Q.Close_COM_Port(E2019Q_ID);