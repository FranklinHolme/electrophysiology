% Compute dim flash sensitivity from calibrated flashes delivered in
% voltage clamp. Use several trials and take the mean response. 

% Parameters 
filename = {'F23041403_0002.abf'};

sweeps = [3:6]; % [] for all 

log_photons_per_micron2_per_s = 6.365; 

stim_dur = 50; % ms 

fit_dur = 15; % seconds after flash to fit with the double exponential 

recording_type = 'dim flash';

channel = 2; % Channel index. Select the lowpass filtered channel. 

cfilt = 2;
cshutter = 4;

baseline_interval = [0, 0.227]; % seconds 

% Calculations 
photons_per_micron2 = 10^log_photons_per_micron2_per_s * stim_dur * 10^-3;

[r] = loadRecording(filename, {recording_type}, []);

r = selectSweeps(r{1}, sweeps); 

rmean = averageEphysTraces2({r}, baseline_interval);

rmean.c.signal_filt = cfilt; 

rmean.c.shutter = cshutter; 

rmean.type = recording_type; 

[rmean] = measureRecordings(rmean, fit_dur, false); 

St = log10(abs(rmean.fitmin) / photons_per_micron2); 

% Plot the mean dim flash response, the single trials, and the curve fit 
f = figure;

plot(r.tt.Time, squeeze(r.tt.trace(:,cfilt,:)));

hold on 

plot(rmean.tt.Time, rmean.tt.trace(:,cfilt,:), 'k');

plot(rmean.fitbounds, rmean.fitpredict, 'r', "LineWidth", 1.5); 

set(f, 'Position', [-6, 859, 1250, 318]);
