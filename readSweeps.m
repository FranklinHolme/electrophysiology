function [sweeps] = readSweeps(sweep_str, signal)

    if strcmp(sweep_str, 'all')    
        sweeps = ['1:', num2str(size(signal, 3))];
    else
        sweeps = ['[', sweep_str, ']'];
    end

end 