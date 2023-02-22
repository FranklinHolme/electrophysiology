function [recordings] = filterRecordings_v2(recordings, fpass)

    for i = 1:length(recordings)

        trace = recordings{i}.tt.trace;

        fs = 1/seconds(recordings{i}.tt.Time(2) - recordings{i}.tt.Time(1)); 

        filt_trace = NaN(size(trace));
        very_filt_trace = NaN(size(trace));

        for c = 1:size(trace, 2)

            for s = 1:size(trace, 3)

                filt_trace(:,c,s) = lowpass(squeeze(trace(:,c,s)), fpass, fs);
                very_filt_trace(:,c,s) = movmean(squeeze(trace(:,c,s)), fs/4);

            end
        end 

        recordings{i}.tt.filt_trace = filt_trace;
        recordings{i}.tt.very_filt_trace = very_filt_trace;

    end 

end