% Shift sweeps from multiple files to common baseline and average them 
function [mean_trace, traces] = averageSweepsFromFileList3(filelist, channel, baseline_window, sweeplist, filt_window)
    
    % Peak at one of the traces to see length 
    [trace, si, ~] = abf2load(filelist{1});
    traces = NaN(1000, size(trace, 1)); % Assumes there won't be more than 1000 sweeps 
    
    % Convert baseline window (in seconds) to baseline samples 
    n_samples = size(trace, 1);
    sample_idxs = 1:n_samples;
    time = sample_idxs * (si * 10^-6);
    baseline_samples = sample_idxs(time > baseline_window(1) & time < baseline_window(2));

    sweeps_itr = 0; 
    
    for i = 1:length(filelist)
        
       [trace, ~, ~] = abf2load(filelist{i});
       
       this_sweeplist = eval(readSweeps(sweeplist{i}, trace)); 
       
       for j = this_sweeplist 
                      
           sweeps_itr = sweeps_itr + 1;
           
           sweep = trace(:,channel,j);
           
           shifted_sweep = sweep - mean(sweep(baseline_samples)); % shift to mean in baseline period
           
           % Filter the sweep
           shifted_sweep_filt = movmean(shifted_sweep, round(filt_window /(si * 10^-6)));

           if sweeps_itr == 1
               trace_sum = shifted_sweep_filt;
           else
               trace_sum = trace_sum + shifted_sweep_filt(1:length(trace_sum));
           end 
           
           % Store the sweep 
           traces(sweeps_itr, 1:length(trace_sum)) = shifted_sweep_filt(1:length(trace_sum));

       end 
       
    end
    
    mean_trace = trace_sum ./ sweeps_itr; 
    
    % remove excess rows of traces matrix 
    traces = traces(1:sweeps_itr, :); 
    
end 



