function [segrecordings] = segmentRecordings(recordings, intervals)

    % Inputs
    % recordings: structs with fields tt, containing time interval with 'Time' and 'trace'
    % intervals: rows are intervals, columns are start and end times
    % in seconds 

    % Outputs
    % segrecordings: copy of the input, except recordings have been
    % segmented to include just the parts within the time intervals. 

    segrecordings = cell(size(recordings)); 

    for i = 1:length(recordings)

        r = recordings{i};

        segr.h = r.h; % copy fields of recording 

        segr.type = r.type;

        segr.c = r.c; 

        if ~isempty(intervals)

            samplesininterval = timerange(seconds(intervals(i, 1)), seconds(intervals(i, 2)));
    
            segr.tt.trace = r.tt.trace(samplesininterval, :, :);
    
            segr.tt.Time = r.tt.Time(samplesininterval) - min(r.tt.Time(samplesininterval)); % start the clock from zero 

        else % if interval is empty, just copy everything over 

            segr.tt.trace = r.tt.trace;

            segr.tt.Time = r.tt.Time; 

        end 

        segrecordings{i} = segr;

    end 

end 