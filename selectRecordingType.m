function [select_recordings] = selectRecordingType(recordings, type)

    select_recordings = {};

    iter = 1;

    for i = 1:length(recordings)
        
        if strcmp(recordings{i}.type, type)

            select_recordings{iter} = recordings{i};

            iter = iter + 1; 

        end 

    end 

end

