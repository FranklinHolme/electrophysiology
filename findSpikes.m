function [spikes] = findSpikes(trace, prominence, showplot)
    [~, locs] = findpeaks(trace, 'MinPeakProminence', prominence);
    if showplot
        figure;
        findpeaks(trace, 'MinPeakHeight', prominence); 
    end
    spikes = zeros(size(trace));
    spikes(locs) = 1;
end