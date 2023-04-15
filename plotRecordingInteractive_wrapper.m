
filename = {'F23041403_0002.abf'};

channel = 2;

recording = loadAbfs2(filename);

plotRecordingInteractive(recording, channel);