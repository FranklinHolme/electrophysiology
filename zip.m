function [zipped] = zip(A, B)
    C = [A(:),B(:)].';   %'
    zipped = C(:);
end 