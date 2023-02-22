function [recordings] = loadAbfs2(filelist)

    recordings = cell(1, length(filelist));

    for i = 1:length(filelist)
        
        [tt, h] = myAbfLoad_v3(filelist{i});

        recordings{i}.tt = tt; % timetable 

        recordings{i}.h = h; % metadata

    end 

end 