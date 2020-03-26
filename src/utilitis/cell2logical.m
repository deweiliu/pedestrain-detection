function label = cell2logical(origianlLabel)
    label = origianlLabel;

    if iscell(label)
        label = cell2mat(label);
    end

    if ischar(label)
        label = str2num(label);
    end

    label = logical(label);
end
