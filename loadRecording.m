function [recordings] = loadRecording(filelist, recording_type, channels)

    % Load files into a cell array of recording structs  
    recordings = loadAbfs2(filelist);

    % For each recording, add user metadata and annotate baseline intervals
    for i = 1:length(recordings)

        recordings{i}.type = recording_type{i}; % A cell array of strings

        recordings{i}.c = channels; % a dictionary of names to channel numbers: c.signal_orig = 1;

    end 

end