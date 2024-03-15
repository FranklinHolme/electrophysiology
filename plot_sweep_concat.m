% Load ephys recordings 
c.signal = 1;
c.shutter = 2;
c.command = 3; 

recordings = loadRecording({'Concatenate552.abf'}, {'pulses'}, c);

r = concatenateSweeps(recordings{1}); 

data = r.tt.trace(:,c.signal);

% Plots
figure

hold on 

plot(r.tt.Time, data, 'k');