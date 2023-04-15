function [seg_trace] = segmentTrace(orig_trace, time_interval)

    seg_trace = orig_trace(timerange(seconds(time_interval(1)), seconds(time_interval(2))), :); % Interval includes start time but not end time 

end