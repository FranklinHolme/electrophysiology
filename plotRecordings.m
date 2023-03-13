function [hs, ts] = plotRecordings(recordings, trace_string, signal_channel, stim, stim_channel, sweeps, xlimit)

    tts = recording2tt(recordings); % Convert recordings to timetables 

    [min_max] = findRecordingsMinMax(recordings, signal_channel);

    for r = 1:length(tts)

        sweep_iter = 1; 
        
        tt = tts{r}; 

        recording = recordings{r};

        hs{r} = figure;
    
        %% Plot each sweep, arranging them vertically in a tiled layout

        if ~isempty(sweeps{r})
            itersweeps = sweeps{r};
        else 
            itersweeps = 1:size(tt.trace,3);
        end 

        nsweeps = length(itersweeps); 
    
        ts{r} = tiledlayout(nsweeps, 1, 'TileSpacing', 'tight');

    
        for i = itersweeps 

            trace = squeeze(tt.(trace_string)(:,recording.c.(signal_channel),i));
    
            nexttile

            if sweep_iter == 1 && stim

                stim_record = squeeze(tt.(trace_string)(:,recording.c.(stim_channel),i));

                stim_record_plot = stim_record * 3 + 1.1 * abs(max(trace)); 

                plot(time2num(tt.Time), stim_record_plot, 'k');

                hold on 

            end

            
            %fs = 1/seconds(tt.Time(2) - tt.Time(1));

            %trace_filt = lowpass(trace, 1000, fs); % 20230209 temporary 
    
            plot(time2num(tt.Time), trace, 'k'); 

            ylimit = min_max;

            ylimit(2) = max(stim_record_plot);
    
            ylim(ylimit);

            if ~isempty(xlimit); xlim(xlimit); end
            
            set(gca, 'TickDir', 'out'); 

            if sweep_iter == 1

                sbar = scalebar();
                sbar.XLen = 1; 
                sbar.XUnit = 'sec.';
                sbar.YLen = 20; 
                sbar.YUnit = recording.h.recChUnits{recording.c.(signal_channel)};
                sbar.hTextY_Pos = [-2.5,-1];
                sbar.hTextX_Pos = [1,-10];
                sbar.Position = [max(xlim)-sbar.XLen, min(trace)+0.05*range(trace)];

            end 

            axis off

            box off 

            sweep_iter = sweep_iter + 1; 
    
        end

        set(hs{r}, 'Position', [0   490   560   860], 'Color', 'w');

    end 

end 