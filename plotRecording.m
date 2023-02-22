function [t] = plotRecording(recording, channel_string)

    tt = recording2tt(recording);
    tt = tt{1}; 

    %% Plot each sweep, arranging them vertically in a tiled layout 

    nsweeps = size(tt.trace, 3);

    t = tiledlayout(nsweeps, 1);

    for i = 1:nsweeps

        nexttile

        plot(tt.Time, squeeze(tt.trace(:,recording.c.(channel_string),i)), 'k'); 

        min_max = findRecordingsMinMax(recordings, channel_string)

    end

end 