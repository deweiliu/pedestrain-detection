function image = parseLine(line)
    texts = char(split(line, ' '));
    texts = cleantexts(texts);
    image.path = texts(1, :);
    image.nPedestrians = str2num(texts(2, :));
    image.boxes = [];
   
    for index = 1:image.nPedestrians
        begin = 3 + 5 * (index - 1);
        
        box = parseBox(texts(begin:begin + 4, :));
        image.boxes = [image.boxes; box];
    end

end

function box = parseBox(texts)
    x = str2num(texts(1, :));
    y = str2num(texts(2, :));
    width = str2num(texts(3, :));
    height = str2num(texts(4, :));
    box = [x, y, width, height];
end

function texts = cleantexts(texts)
    index = 1;

    while index <= size(texts, 1)

        if texts(index, 1) == ' '
            % If this row is empty
            texts(index, :) = [];
        else
            index = index + 1;
        end

    end

end
