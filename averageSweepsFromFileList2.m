% Shift sweeps from multiple files to common baseline and average them 
function [mean_trace] = averageSweepsFromFileList2(filelist, channel, baseline_samples, sweeps2average)
    total_sweeps = 0; 
    for i = 1:length(filelist)
       [trace, ~, ~] = abf2load(filelist{i});
       for j = sweeps2average(i, :)
           total_sweeps = total_sweeps + 1;
           sweep = trace(:,channel,j);
           shifted_sweep = sweep - mean(sweep(baseline_samples)); % shift to mean in baseline period
           if total_sweeps == 1
               trace_sum = shifted_sweep;
           else
               trace_sum = trace_sum + shifted_sweep;
           end 

       end 
    end
    mean_trace = trace_sum ./ total_sweeps; 
end 
