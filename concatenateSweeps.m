function [r] = concatenateSweeps(r)

    trace = r.tt.trace; 

    newtrace = NaN(size(trace, 1) * size(trace, 3), size(trace, 2));

    for i = 1:size(trace, 2) % iterate channels

         cat = squeeze(trace(:, i, :));

         newtrace(:, i) = cat(:);

    end 

    newtime = (0:(length(newtrace)-1)) * r.h.si * 10^-6;

    newtt.trace = newtrace;

    newtt.Time = newtime;

    r.tt = newtt;

end  