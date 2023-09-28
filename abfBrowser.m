function [] = abfBrowser(selpath, sweeps)
    
    if isempty(selpath)
        [filelist, ~] = uigetfile('*.abf',...
       'Select One or More Files', ...
       'MultiSelect', 'on');
    else
        cd(selpath); 
        filelist = dir('*.abf'); 
    end

    displayTraces(filelist, sweeps);

end


function [] = displayTraces(filelist, sweeps)
    for i = 1:length(filelist)
        fig = figure;
        
        if iscell(filelist)
            cur_filename = filelist{i};
            
        else 
            cur_filename = filelist(i).Name; 
        end 

        t = tiledlayout('flow');
%        t.title(cur_filename, 'Interpreter', 'none');
        xlabel(t, 'Time (sec.)');
        ylabel(t, 'Signal'); 
        [data, si, h] = abf2load(cur_filename);
        n_samples = size(data, 1);
        time = (1:n_samples) * (si * 10^-6);
        
        if isempty(sweeps)
            these_sweeps = 1:size(data, 3);
        else
            these_sweeps = sweeps(i);
        end

        for j = these_sweeps
            nexttile
            plot(time, data(:,:,j));
            if j == these_sweeps(1); legend(h.recChUnits); end
        end
        
        set(fig, 'Position', [5         271        1912         707]);
        pause();
        %close(fig);
    end
end