% Load model outputs saved from colab 
m440_440 = readtable('currentGlobalGain.csv');

normsim = -1 * m440_440.CurrentGlobalGain / max(m440_440.CurrentGlobalGain);

% Load ephys recordings 
c.signal = 1;
c.shutter = 2;
c.command = 3; 

recordings = loadRecording({'Viet 440 440 3 Hz lowpass.abf'}, {'pulses'}, c);

r = concatenateSweeps(recordings{1}); 

data = r.tt.trace(:,c.signal);

data = data-max(data); % shift to 0 baseline 

normdata = data / (-1 * min(data));


% Plots
figure

hold on 

plot(r.tt.Time, normdata, 'k');

plot(m440_440.Time, normsim, 'r')

legend({'Data', 'Model'});


% Synchronize the data to the model output. This will be useful for
% parameter estimation methods. 
mtt = timetable(seconds(m440_440.Time), normsim);

dtt = timetable(seconds(r.tt.Time)', normdata);

mdtt = synchronize(dtt, mtt, mtt.Time, 'linear');

figure

hold on 

plot(mdtt.Time, mdtt.normdata, 'k');

plot(mdtt.Time, mdtt.normsim, 'r');

downsampled_data = mdtt.normdata;

writematrix(downsampled_data, 'Viet 440 440 model fitting.csv');


