function [recordings] = measureRecordings(recordings, fit_dur, plotfit)

    
    for i = 1:length(recordings)

        if length(recordings) > 1
            recording = recordings{i}; % unpack
        else
            recording = recordings; 
        end 

        m_recording = recording; % copy so changes made during measurements are reversible 

        % If recording is a dim flash response, fit a double exponential 
        if strcmp(m_recording.type, 'local') || strcmp(m_recording.type, 'global') ...
                || strcmp(m_recording.type, 'dim flash')...
                || strcmp(m_recording.type, 'dim flash mean')...
                || strcmp(m_recording.type, 'local mean')...
                || strcmp(m_recording.type, 'global mean')

            % Find the time of the start of the flash 
            shutter_c = m_recording.c.shutter;
            [~, flash_idx] = max(diff(m_recording.tt.trace(:, shutter_c)));

            % Select recording after the flash
           m_recording.tt = m_recording.tt(m_recording.tt.Time > m_recording.tt.Time(flash_idx)...
               & m_recording.tt.Time < m_recording.tt.Time(flash_idx) + seconds(fit_dur), :);
    
            x = seconds(m_recording.tt.Time);
            y = m_recording.tt.trace(:, m_recording.c.signal_filt);
    
            [fitresult, gof] = doubleExpFit(x, y, plotfit);

            yfit = fitresult(x);

            % Save results in the recording struct 
            recording.fitresult = fitresult;

            recording.gof = gof;

            recording.fitpredict = yfit;

            recording.fitmin = min(yfit);

            recording.fitbounds = m_recording.tt.Time;

        end 

         if length(recordings) > 1
             
             recordings{i} = recording; % repack 

         else 

             recordings = recording;

         end 
    end 

end