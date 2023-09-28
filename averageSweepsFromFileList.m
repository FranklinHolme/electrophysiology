% Shift sweeps from multiple files to common baseline and average them 
function [mean_trace] = averageSweeps(filelist, channel, baseline_samples)
    total_sweeps = 0; 
    for i = 1:length(filelist)
       [trace, ~, ~] = abf2load(filelist{i});
       n_sweeps = size(trace, 3); 
       for j = 1:n_sweeps
           total_sweeps = total_sweeps + 1;
           sweep = trace(:,channel,j);
           shifted_sweep = sweep - mean(sweep(baseline_samples)); % shift to mean in baseline period
           if i == 1 && j == 1
               trace_sum = shifted_sweep;
           else
               trace_sum = trace_sum + shifted_sweep(1:length(trace_sum));
           end 

       end 
    end
    mean_trace = trace_sum ./ total_sweeps; 
end 
