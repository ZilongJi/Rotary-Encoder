classdef E2019Q
    methods(Static)
        %%%%%%%%%%%%%%%% OPEN/CLOSE COM port functions %%%%%%%%%%%%%%%%%%%%
        % Open COM  Port for E201-9Q
        function FID = Open_COM_Port(ComString)
            FID = serial(ComString);
            FID.Terminator = '';
            fopen(FID);
        end
        
        % Close COM Port for E201-9Q
        function Close_COM_Port(FID)
            fclose(FID);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%% Status functions %%%%%%%%%%%%%%%%%%%%%%%%%%
        % Read software version of E201-9Q
        function data = GetSoftwareVersion(FID)
            fprintf(FID,'v');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Read serial number of E201-9Q
        function data = GetSerialNumber(FID)
            fprintf(FID,'s');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Read encoder supply status, voltage and current consumption
        function data = GetEncSupply(FID)
            fprintf(FID,'e');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Read status of hardware input pins on interface
        function data = GetInputPinStatus(FID)
            fprintf(FID,'p');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%% Power management functions %%%%%%%%%%%%%%%%%%%%%
        % Turn ON power supply to encoder
        function data = EncSupply_ON(FID)
            fprintf(FID,'n');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Turn OFF power supply to encoder
        function data = EncSupply_OFF(FID)
            fprintf(FID,'f');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%% Functions related to the encoder position %%%%%%%%%%%%
        % Read encoder position (string, decimal)
        function data = GetEncPosition(FID)
            fprintf(FID,'?');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Read encoder position (string, decimal) with timestamp
        function data = GetEncPosition_Timestamp(FID)
            fprintf(FID,'!');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Read encoder position (string, HEX)
        function data = GetEncPositionHEX(FID)
            fprintf(FID,'>');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Read encoder position (string, HEX) with timestamp
        function data = GetEncPositionHEX_Timestamp(FID)
            fprintf(FID,'<');
            data = [];
            start = clock;
            while(isempty(strfind(data, 13)))
                if FID.BytesAvailable > 0
                    data = [data fscanf(FID,'%c',FID.BytesAvailable)];
                end
                if etime(clock,start) > 3
                    disp('Timeout occurs while reading COM port');
                    break
                end
            end
        end
        
        % Clear reference status flag
        function ClearReferenceFlag(FID)
            fprintf(FID,'c');
        end
        
        % Set current count value to zero (also affects reference mark)
        function ResetCurrentCount(FID)
            fprintf(FID,'z');
        end
        
        % Clear zero offset value stored by "ResetCurrentCount" function
        function ClearZeroOffset(FID)
            fprintf(FID,'a');
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%% String to Double converting functions %%%%%%%%%%%%%
        % Get encoder count in double precision format
        function data = GetEncCountDOUBLE(FID)
            temp = E2019Q.GetEncPosition(FID);
            data = str2double(temp(2:min(strfind(temp,':')-1)));
        end
        
        % Get encoder reference mark in double precision format
        function data = GetEncReferenceDOUBLE(FID)
            temp = E2019Q.GetEncPosition(FID);
            data = str2double(temp(min(strfind(temp,':'))+2:max(strfind(temp,':'))-1));
        end
        
        % Get timestamp of position in double precision format
        function data = GetTimestampDOUBLE(FID)
            temp = E2019Q.GetEncPosition_Timestamp(FID);
            data = str2double(temp(max(strfind(temp,':'))+2:end-1));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
