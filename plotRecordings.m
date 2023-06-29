function [hs, ts] = plotRecordings(recordings, trace_string, signal_channel, stim, stim_channel, sweeps, xlimit, ylimit, overlay, xaxisvisible)

    tts = recording2tt(recordings); % Convert recordings to timetables 

    [min_max] = findRecordingsMinMax(recordings, signal_channel);

    for r = 1:length(tts)

        sweep_iter = 1; 
        
        tt = tts{r}; 

        recording = recordings{r};

        hs{r} = figure;

        hold on 
    
        %% Plot each sweep, arranging them vertically in a tiled layout

        if ~isempty(sweeps{r})
            itersweeps = sweeps{r};
        else 
            itersweeps = 1:size(tt.trace,3);
        end 

        nsweeps = length(itersweeps); 
    
        if ~overlay
            
            ts{r} = tiledlayout(nsweeps, 1, 'TileSpacing', 'tight');

        end 
    
        for i = itersweeps 

            trace = squeeze(tt.(trace_string)(:,recording.c.(signal_channel),i));
    
            if ~overlay; nexttile; end

            if sweep_iter == 1 && stim

                hold on 

                stim_record = squeeze(tt.(trace_string)(:,recording.c.(stim_channel),i));

                stim_record_plot = stim_record * 1 + 1.1 * abs(max(trace)); 

                plot(time2num(tt.Time), stim_record_plot - (min(stim_record_plot) - min_max(2)), 'k');

                %plot(time2num(tt.Time), stim_record_plot - 20, 'k');

            end

            
            %fs = 1/seconds(tt.Time(2) - tt.Time(1));

            %trace_filt = lowpass(trace, 1000, fs); % 20230209 temporary 
    
            plot(time2num(tt.Time), trace, 'k'); 

            if isempty(ylimit); ylimit = min_max; end

            set(gca, "YTick", -2000:20:2000); % limits that make sense for single cell ephys 

            if stim && isempty(ylimit); ylimit(2) = max(stim_record_plot); end
    
            ylim(ylimit);

            if ~isempty(xlimit); xlim(xlimit); end
            
            set(gca, 'TickDir', 'out'); 

            if sweep_iter == 1

%                 sbar = scalebar();
%                 sbar.XLen = 1; 
%                 sbar.XUnit = 'sec.';
%                 sbar.YLen = 10; 
%                 sbar.YUnit = recording.h.recChUnits{recording.c.(signal_channel)};
%                 sbar.hTextY_Pos = [-2.5,-1];
%                 sbar.hTextX_Pos = [1,-10];
%                 sbar.Position = [max(xlim)-sbar.XLen, min(trace)+0.05*range(trace)];

            end 

            h = gca;

            h.XAxis.Visible = xaxisvisible;

            box off 

            sweep_iter = sweep_iter + 1; 
    
        end

        set(hs{r}, 'Position', [0   490   560   860], 'Color', 'w');

    end 

end 