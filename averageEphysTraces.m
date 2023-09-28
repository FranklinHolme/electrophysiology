% Shift ephys recordings to a common baseline and average them. 
function [mean_trace] = averageEphysTraces(recordings, baseline_interval)
    
    n_traces = 0; % iterator 

    for i = 1:length(recordings)

       record = recordings{i}; % traces are in a timetable 

       if ~isempty(baseline_interval) % If there's a time interval, segment the recording to capture the baseline 

            baseline_record = segmentTrace(record, baseline_interval); 

       else % otherwise find the baseline using information about the protocol contained in the recording 

           baseline_record = record(strcmp(record.analysis_epoch, 'baseline'), :);

       end 

       for sweep = 1:size(record, 3)

            shifted_trace = record.very_filt_trace(:,:,sweep) - mean(baseline_record.very_filt_trace(:,:,sweep)); % shift to mean in baseline period

            n_traces = n_traces+1;

       end 

       if i == 1 

               trace_sum = shifted_trace;

       else

               trace_sum = trace_sum + shifted_trace(1:length(trace_sum)); % First trace determines the length of the average trace. Anything longer will be truncated.

       end 

    end

    mean_trace = trace_sum ./ n_traces; 

end 
