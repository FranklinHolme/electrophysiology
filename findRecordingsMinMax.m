function [min_max] = findRecordingsMinMax(recordings, channel_string)

    min_max = [inf, -inf];

    for i = 1:length(recordings) 

        signal = squeeze(recordings{i}.tt.trace(:, recordings{i}.c.(channel_string), :));

        min_max = [min([min(signal(:), min_max(1))]), max([max(signal(:)), min_max(2)])];

    end 

end