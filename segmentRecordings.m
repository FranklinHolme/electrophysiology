function [segrecordings] = segmentRecordings(recordings, intervals)

    % Inputs
    % recordings: structs with fields tt (a timetable), containing time interval with 'Time' and 'trace'
    % intervals: rows are intervals, columns are start and end times
    % in seconds 

    % Outputs
    % segrecordings: copy of the input, except recordings have been
    % segmented to include just the parts within the time intervals. 

    segrecordings = cell(size(recordings)); 

    for i = 1:length(recordings)

        r = recordings{i};

        % copy fields of recording that don't need to be segmented in time 
        segr.h = r.h; 

        segr.type = r.type;

        segr.c = r.c; 


        if ~isempty(intervals) && ~isnan(intervals(i, 1)) % Intervals left as empty or NaN to skip segmentation 

            samplesininterval = timerange(seconds(intervals(i, 1)), seconds(intervals(i, 2)));

            segr.tt = r.tt(samplesininterval, :);

            segr.tt.Time = r.tt.Time(samplesininterval) - min(r.tt.Time(samplesininterval)); % start the clock from zero 

        else % if interval is empty, just copy everything over 

            segr = r; 
            
        end 

        segrecordings{i} = segr;

    end 

end 