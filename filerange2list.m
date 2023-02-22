function [flst] = filerange2list(frange)

% Input frange: cell array of first and last filename in a list. 
% Example: {'F22110201_0006.abf','F22110201_0012.abf'}

% Output flist: cell array of full file list. 
% Example: {'F22110201_0006.abf', 'F22110201_0007.abf', 'F22110201_0008.abf', 'F22110201_0009.abf', 'F22110201_0010.abf'}

% Key assumption is that the we have to figure out just how to increment
% the parts of the filenames that change between first and last. THIS IS
% ONLY IMPLEMENTED FOR NUMBERS. ({'a.tif', 'c.tif'} will not work). Also
% assumes that increment between filenames is always +1 and the padding
% characters are '0'

    % Only two elements allowed in frange
    if length(frange) ~= 2; error('file range must contain two elements'); end 

    % Both elements of frange must be strings 
    if ~ischar(frange{1}) || ~ischar(frange{2}); error('File range must consist of strings'); end 

    % Find indices of characters that will change - anything between the
    % different character and the file extension (this last part is a TO DO) 
    diffi = ~(frange{1} == frange{2});
    ext_i = find('.' == frange{1});
    diffi(ext_i - 1) = 1; 
    diffi = imclose(diffi, [1 1]); 

    % Extract the numbers in filenames at the start and end of the filelist 
    i_start = str2num(frange{1}(diffi));
    i_end = str2num(frange{2}(diffi)); 

    i_range = i_start:i_end; 

    % Make the filelist 
    flst = cell(1, length(i_range));

    flst{1} = frange{1};
    flst{end} = frange{2};

    template = flst{1}; 
    max_length = sum(diffi); 

    for i = 2:(length(flst) - 1)

        fname = template;

        iternum = i_range(i);

        iterchari = num2str(iternum);
   
        iterchars = repelem('0', max_length); % pad with 0s to match to maximum string length 

        iterchars((end - (length(iterchari) - 1)):end) = iterchari; 

        fname(diffi) = iterchars; 

        flst{i} = fname;

    end

end 