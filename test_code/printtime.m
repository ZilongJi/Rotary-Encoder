while true
    current_time = clock;
    fprintf('Current time: %02d:%02d:%02d\n', current_time(4), current_time(5), round(current_time(6)));
    pause(1 - mod(current_time(6),1)); % Wait for the remaining time in the second
end
