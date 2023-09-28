function [hs, ts] = plotRecordingsMultichannel(recordings, trace_string, signal_channels, stim, stim_channel, sweeps, userxlimit, userylimit, overlay, xaxisvisible)

    tts = recording2tt(recordings); % Convert recordings to timetables 

    for r = 1:length(tts)

        figure_iter = 1;
        
        tt = tts{r}; 

        recording = recordings{r};

        hold on 
    
        %% Plot each channel, arranging them vertically in a tiled layout. Sweeps are plotted in seaparate figures.

        if ~isempty(sweeps{r})
            itersweeps = sweeps{r};
        else 
            itersweeps = 1:size(tt.trace,3);
        end 

        nchannels = length(signal_channels); 
    
        for i = itersweeps 

            hs{figure_iter} = figure;

            if ~overlay
               
                ts{figure_iter} = tiledlayout(nchannels, 1, 'TileSpacing', 'tight');
    
            end

            chan_iter = 1;

            for c = 1:nchannels

                [min_max] = findRecordingsMinMax(recordings, trace_string{c}, signal_channels{c}); 

                trace = squeeze(tt.(trace_string{c})(:,recording.c.(signal_channels{c}),i));
        
                if ~overlay; nexttile; end
    
                if chan_iter == 1 && stim
    
                    hold on 
    
                    stim_record = squeeze(tt.('trace')(:,recording.c.(stim_channel),i));
    
                    stim_record_plot = stim_record * 1 + 1.1 * abs(max(trace)); 
    
                    plot(time2num(tt.Time), stim_record_plot - (min(stim_record_plot) - min_max(2)), 'k');
        
                end
    

                plot(time2num(tt.Time), trace, 'k'); 
    
                ylimit = min_max;

                xlimit = [min(time2num(tt.Time)) max(time2num(tt.Time))];
    
                %set(gca, "YTick", ylim(1):(ylim(2) - ylim)); % limits that make sense for single cell ephys 
    
                if chan_iter == 1 && stim;  ylimit(2) = max(stim_record_plot); end
        
                if isempty(userylimit) 

                    ylim(ylimit);

                else

                    if iscell(userylimit) % user can specify one ylimit for each channel as a cell array

                        if isempty(userylimit{c})

                            ylim(ylimit)

                        else

                            ylim(userylimit{c});

                        end
                        
                    else   

                        ylim(userylimit);

                    end 

                end 
    
                if isempty(userxlimit) 
                    
                    xlim(xlimit);

                else

                    xlim(userxlimit);

                end
                
                set(gca, 'TickDir', 'out'); 
    
                h = gca;
    
                h.XAxis.Visible = xaxisvisible;
    
                box off 
    
                chan_iter = chan_iter + 1; 
    
            end

            set(hs{figure_iter}, 'Position', [443   776   454   451], 'Color', 'w');

            figure_iter = figure_iter + 1;

        end   

    end 

end 