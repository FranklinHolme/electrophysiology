function [etimes] = findEvents(recordings, params)

    etimes = {};

    for i = 1:length(recordings)

        etimes{i} = findEventsRecording(recordings{i}, params);

    end 

end 


function [etimes] = findEventsRecording(r, params) 

    % convert full width half max parameter from time to samples
    fwhm_samples = sum(r.tt.Time < seconds(params.event_deriv_fwhm));

    for s = 1:size(r.tt.trace, 3)

        trace = r.tt.trace(:, params.c, s);
    
        deriv = [0; diff(trace)];
    
        [~, e_idxs] = findpeaks(deriv, "MinPeakHeight", params.event_deriv, ...
            "MinPeakProminence", params.event_deriv / 2, ...
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