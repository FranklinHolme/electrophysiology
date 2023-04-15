function [rnew] = selectSweeps(r, sweeps)

    rnew = r;

    if max(sweeps) <= size(r.tt.trace, 3)

        if ~isempty(sweeps)
    
            rnew.tt.trace = r.tt.trace(:,:,sweeps);
    
        end

    else

        rnew.tt.trace = r.tt.trace(:,:,sweeeps(1):end);

        warning('Attempted to select more sweeps than exist in the recording');

    end 

end