function [tt, f] = plotRecordingInteractive(recording, c)

    tt = recording2tt(recording);
    tt = tt{1}; 

    nsweeps = size(tt.trace, 3);

    f= figure;

    % plot all traces 
    plot(tt.Time, squeeze(tt.trace(:,c,:)), 'k'); 

    hold on 

    i = 1; 

    quit = false; 

    while ~quit 

        % plot selected trace 
        plot(tt.Time, squeeze(tt.trace(:,c,i)), 'r'); 

        title(['Sweep ', num2str(i)]);

        %min_max = findRecordingsMinMax(recordings, channel_string);

        k = waitforbuttonpress;
        % 28 leftarrow
        % 29 rightarrow
        % 30 uparrow
        % 31 downarrow
        value = double(get(gcf,'CurrentCharacter'));

        try

            switch value 
                
                case 28
    
                    i = i - 1;
    
                case 29 
    
                    i = i + 1; 
    
                case 30 
    
                    quit = true; 
    
                case 31 
    
                    quit = true;
    
            end 

            if i > nsweeps; i = nsweeps; end 
    
            if i < 1; i = 1; end 

            l = findobj(gca,'Type','line');

            l(1).Color = 'k'; 

        catch
            
            warning('Got some strange GUI input');

        end

    end

end 