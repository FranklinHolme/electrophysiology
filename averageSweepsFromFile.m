% Shift sweeps from multiple files to common baseline and average them
function [mean_trace] = averageSweepsFromFile(file, channel, baseline_samples, sweeps2average)
    total_sweeps = 0;
    [trace, ~, ~] = abf2load(file);
    for j = sweeps2average
        total_sweeps = total_sweeps + 1;
        sweep = trace(:,channel,j);
        shifted_sweep = sweep - mean(sweep(baseline_samples)); % shift to mean in baseline period
        if total_sweeps == 1
            trace_sum = shifted_sweep;
        else
            trace_sum = trace_sum + shifted_sweep;
        end

    end
    mean_trace = trace_sum ./ total_sweeps;
end
