function [traces] = segmentTraces(orig_traces, time_intervals)

    % Inputs
    % orig_traces: timetables with fields 'Time' and 'trace'
    % time intervals: rows are intervals, columns are start and end times 

    % Outputs
    % traces: timetables with fields 'Time' and 'trace', cut from
    % orig_traces within the time intervals. Empty entries exist if data
    % does not exist for a given time interval. n_traces x n_intervals

    n_traces = length(orig_traces);

    n_intervals = size(time_intervals, 1); 

    traces = cell(n_traces, n_intervals); 
    
    for i = 1:n_traces

        for j = 1:n_intervals

            traces{i, j} = segmentTrace(orig_traces{i}, time_intervals(j,:));

        end 

    end 

end 


function [seg_trace] = segmentTrace(orig_trace, time_interval)

    seg_trace = orig_trace(timerange(seconds(time_interval(1)), seconds(time_interval(2))), :); % Interval includes start time but not end time 

end