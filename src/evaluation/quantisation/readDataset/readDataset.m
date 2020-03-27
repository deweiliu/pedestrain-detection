function images = readDataset(filePath)
    id = fopen(filePath);
    fileName = fgets(id);
    nImages = str2num(fgets(id));
    images = [];

    for imageIndex = 1:nImages
        line = fgets(id);
        image = parseLine(line);
        images = [images; image];
    end

    fclose(id);
end
