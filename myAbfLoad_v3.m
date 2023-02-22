function [tt, h] = myAbfLoad_v3(filename)

    [trace, si, h] = abf2load(filename);

    n_samples = size(trace, 1);

    time = (1:n_samples) * (si * 10^-6); % convert microseconds to seconds 
        
    tt = timetable(seconds(time'), trace);

end