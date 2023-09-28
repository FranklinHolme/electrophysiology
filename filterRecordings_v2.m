function [recordings] = filterRecordings_v2(recordings, fpass)

    for i = 1:length(recordings)

        trace = recordings{i}.tt.trace;

        fs = 1/seconds(recordings{i}.tt.Time(2) - recordings{i}.tt.Time(1)); 

        filt_trace = NaN(size(trace));

        very_filt_trace = NaN(size(trace));

        deriv_trace = NaN(size(trace));

        deriv_filt_trace = NaN(size(trace));

        for c = 1:size(trace, 2)

            for s = 1:size(trace, 3)

                filt_trace(:,c,s) = bandpass(squeeze(trace(:,c,s)), fpass, fs);

                very_filt_trace(:,c,s) = movmean(squeeze(trace(:,c,s)), fs/4);

                deriv_trace(:,c,s) = [0; diff(trace(:,c,s))] / recordings{i}.h.si * 10^3; % convert to mv/ms and store 

                deriv_filt_trace(:,c,s) = [0; diff(filt_trace(:,c,s))] / recordings{i}.h.si * 10^3; % convert to mv/ms and store 

            end
        end 

        recordings{i}.tt.filt_trace = filt_trace;

        recordings{i}.tt.very_filt_trace = very_filt_trace;

        recordings{i}.tt.deriv_trace = deriv_trace;

        recordings{i}.tt.deriv_filt_trace = deriv_filt_trace;

    end 

end