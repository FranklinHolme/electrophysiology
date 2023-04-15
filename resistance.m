function [R] = resistance(tt, channels, pulse_magnitude, pulse_interval, baseline_interval, show_plot)

% Calculates resistance from the response to a hyperpolarizing pulse in
% voltage clamp as R = magnitude(steady state current) / magnitude(pulse) 

% Input tt: time table with 'Time' and 'trace' fields

% Input channels: struct with field 'signal_orig' containing an index for
% the signal 

% Input pulse_magnitude: magnitude of the test pulse, in
% millivolts

% Input pulse_interval: pulse interval, in seconds (array of durations e.g.,
% [0.24, 0.32] 

% Input baseline_interval: pulse interval, in seconds (array of durations e.g.,
% [0.24, 0.32] 

% Input show_plot: make plot of the pulse interval? (boolean) 

% Output: array of R measurements, one for each sweep 

    % For each sweep, divide by the magnitude of the steady state current 
    n_sweeps = size(tt.trace, 3);

    R = NaN(1, n_sweeps);

    hyperpol_samples = tt.Time > pulse_interval(1) & tt.Time < pulse_interval(2);

    baseline_samples = tt.Time > baseline_interval(1) & tt.Time < baseline_interval(2); 

    for sweep = 1:n_sweeps

        % Find hyperpolarizing pulses in the recording - epochs with
        % a step of negative current 

        trace = tt.trace(:, channels.signal_orig, sweep);

        hyperpol_trace = trace(hyperpol_samples);

        baseline_trace = trace(baseline_samples);

        I_magnitude = mean(hyperpol_trace) - mean(baseline_trace);
    
        R(sweep) = abs(pulse_magnitude) / abs(I_magnitude); % R = V/I. mV/pA => gigaohms
% 
%         if show_plot % too many plots
% 
%             figure
%             plot(tt.Time, trace)
%             hold on 
%             plot(tt.Time(hyperpol_samples), hyperpol_trace)
%             title(['R = ', num2str(R(sweep)), ' Gigaohms']);
% 
%         end 

    end 

    if show_plot

         figure
         plot(R, '.-k');
         xlabel('Sweep');
         ylabel('Resistance (Gigaohms)');

    end 

end 