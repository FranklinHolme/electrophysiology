function [Rs] = seriesResistance_v2(tt, channels)

% Calculates series resistance from the response to a hyperpolarizing pulse
% as Rs = magnitude(capacitance transient) / magnitude(pulse) 

% Input tt: time table with 'Time' and 'trace' fields

% Input channels: struct with fields 'signal_orig' and 'cmd' containing
% integers denoting which channels of 'trace' correspond to these data 

% Output: array of Rseries measurements, one for each sweep 

    % For each sweep, divide by the magnitude of the capacitance transient 
    n_sweeps = size(tt.trace, 3);

    Rs = NaN(1, n_sweeps);

    for sweep = 1:n_sweeps

        % Find a hyperpolarizing pulse in the recording - the first epoch with
        % a membrane potential less than the modal potential. Copy this segment
        % of the recording
        cmd = squeeze(tt.trace(:, channels.cmd, sweep));

        hyperpol_epoch = tt(cmd < 1.05*median(cmd), sweep);

        pulse_magnitude = median(squeeze(hyperpol_epoch.trace(:,channels.cmd, sweep))) - median(cmd); 

        cap_transient_magnitude = min((hyperpol_epoch.trace(:, channels.signal_orig, sweep))) - median(tt.trace(:, channels.signal_orig, sweep));
    
        Rs(sweep) = abs(pulse_magnitude) / abs(cap_transient_magnitude) * 10^3; % Rs = V/I. mV/pA * 10^3 => Mohms 

    end 

end 