% Characterize a recording using the perforation protocol 

% Parameters 
filename = {'F23041403_0001.abf'};

hyper_pulse = -10; % mV 

pulse_interval = seconds([0.24, 0.32]); % seconds 

baseline_interval = seconds([0, 0.227]); % seconds 

show_plot = true; 

% channels 
chan.signal_orig = 1;


% Calculations 
r = loadAbfs2(filename);

tt = r{1}.tt;

baseline_samples = tt.Time > baseline_interval(1) & tt.Time < baseline_interval(2); 

R = resistance(tt, chan, hyper_pulse, pulse_interval, baseline_interval, show_plot);

Ihold = squeeze(mean(tt.trace(baseline_samples, chan.signal_orig, :))); 