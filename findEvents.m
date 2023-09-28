function [etimes] = findEvents(recordings, params)

    etimes = {};

    for i = 1:length(recordings)

        etimes{i} = findEventsRecording(recordings{i}, params);

    end 

end 


function [etimes] = findEventsRecording(r, params) 

    % convert full width half max parameter from time to samples
    fwhm_samples = sum(r.tt.Time < seconds(params.fwhm));

    for s = 1:size(r.tt.trace, 3)

        trace = r.tt.(params.trace_name)(:, params.c, s);
    
        [~, e_idxs] = findpeaks(trace, "MinPeakHeight", params.event_size, ...
            "MinPeakProminence", params.event_size / 2, ...
            "MinPeakWidth", fwhm_samples);
    
        etimes{s} = r.tt.Time(e_idxs); 
    
        figure
    
        hold on 
    
        yyaxis left 
        plot(r.tt.Time, trace, 'k');
    
        plot(r.tt.Time(e_idxs), trace(e_idxs), 'ob');
        
        yyaxis right
        plot(r.tt.Time, deriv, 'r');

    end 

end 