function [rs] = selectSweeps2(r, s)

% Selects sweeps from a recording

% Input r: recording 

% Input s: sweep (integer or array of integers) 

% Return rs: recording with only the selected sweeps

    if iscell(r); r = r{1}; end

    rs = r;
    
    fieldnames = r.tt.Properties.VariableNames;
    
    for i = 1:length(fieldnames)


        rs.tt.(fieldnames{i}) = r.tt.(fieldnames{i})(:, :, s);

    end

end