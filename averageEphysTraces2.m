% Shift ephys recordings to a common baseline and average them. 
function [mean_record] = averageEphysTraces2(recordings, baseline_interval)

    tts = recording2tt(recordings);
    
    n_traces = 0; % iterator 

    for i = 1:length(recordings)

       tt = tts{i}; % extract timetable

       if ~isempty(baseline_interval) % If there's a time interval, segment the recording to capture the baseline 

            baseline_tt = segmentTrace(tt, baseline_interval); 

       else % otherwise find the baseline using information about the protocol contained in the recording 

           baseline_tt = tt(tt.baseline, :);

       end 

       for sweep = 1:size(tt.trace, 3)

            shifted_trace = tt.trace(:,:,sweep) - mean(baseline_tt.trace(:,:,sweep)); % shift to mean in baseline period

            n_traces = n_traces+1;
 

           if sweep == 1 && i == 1
    
                   trace_sum = shifted_trace;
    
           else
    
                   trace_sum = trace_sum + shifted_trace(1:length(trace_sum),:); % First trace determines the length of the average trace. Anything longer will be truncated.
    
           end

       end

    end

    mean_trace = trace_sum ./ n_traces; 

    mean_record.tt = timetable();

    mean_record.tt.trace = mean_trace;

    mean_record.tt.Time = recordings{1}.tt.Time; % Copy timebase from first recording. 

    mean_record.c = recordings{1}.c;

    mean_record.h = recordings{1}.h;

    mean_record.type = [recordings{1}.type, ' mean'];

end 
