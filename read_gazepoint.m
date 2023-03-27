function gzp = read_gazepoint(filename)

gzp.header  = {};
gzp.label   = {};
gzp.dat     = [];
current     = 0;

% read the whole file at once
fid = fopen(filename, 'r');
if fid == -1
    error('Error opening file')
end
aline = fread(fid, inf, 'char=>char');          % returns a single long string
fclose(fid);

aline(aline==uint8(sprintf('\r'))) = [];        % remove cariage return
aline = tokenize(aline, uint8(sprintf('\n')));  % split on newline

mode = 'header';
for iLine=1:numel(aline)
    tline = aline{iLine};

    if contains(tline, '[Paradigm Data Format]')
        mode = 'colnames';
    elseif contains(tline, 'Paradigm Data')
        mode = 'data';
    else
        if strcmpi(mode, 'header')
            gzp.header = cat(1, gzp.header, {tline});

            if contains(tline, 'Sampling Rate')
                tmp = split(tline);
                gzp.srate = str2num(tmp{4});
            end
        elseif strcmpi(mode, 'colnames')
            % ignore for now
        elseif strcmpi(mode, 'data')
            tmp = importdata(filename, '\t', iLine);
            gzp.label = tmp.colheaders;
            gzp.dat   = tmp.data';
            break
        end
    end
end
