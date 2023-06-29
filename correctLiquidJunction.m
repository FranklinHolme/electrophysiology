function [recordings] = correctLiquidJunction(recordings, ljpcorrection)

    for i = 1:length(recordings)

        r = recordings{i};

        units = r.h.recChUnits; 

        for s = 1:size(r.tt.trace, 3) % iterate sweeps      

            for c = 1:length(units) % iterate channels (that have units)  

                % for any channels in mV, apply the correction 
                if strcmp(units{c}, 'mV')

                    r.tt.trace(:, c, s) = r.tt.trace(:, c, s) + ljpcorrection;

                end 

            end 

        end

        recordings{i} = r;

    end

end