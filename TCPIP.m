t = tcpip('128.40.254.106', 5005, 'NetworkRole', 'server');
fopen(t);

while true
    if t.BytesAvailable > 0
        msg = fscanf(t);
        disp(msg);
    end
end
fclose(t);
