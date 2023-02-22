function [tts] = recording2tt(recordings)
    
    if ~iscell(recordings); recordings = {recordings}; end

    tts = cell(size(recordings));

    for i = 1:length(recordings)

        tts{i} = recordings{i}.tt;

    end

end