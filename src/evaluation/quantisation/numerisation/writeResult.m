function filePath = writeResult(results, method, output)
    fileName = sprintf("%s.dataset", method);
    filePath = fullfile(output, fileName);
    fileID = fopen(filePath, 'w');

    nFrames = size(results, 1);
    fprintf(fileID, "%sDataset\n", method);
    fprintf(fileID, "%d\n", nFrames);

    for frameIndex = 1:nFrames
        text = dataText(results(frameIndex));
        fprintf(fileID, "%s\n", text);
    end

    fclose(fileID);
end

function text = dataText(result)
    text = "";

    framePath = result.framePath;
    [pathstr, name, ext] = fileparts(framePath);
    text = text + sprintf("images/%s%s", name, ext);

    data = result.data;
    nPedestrians = size(data, 1);
    text = text + sprintf("%4d", nPedestrians);

    for dataIndex = 1:size(result.data, 1)
        box = data(dataIndex);
        text = text + sprintf("%8.2f", box.x);
        text = text + sprintf("%8.2f", box.y);
        text = text + sprintf("%8.2f", box.width);
        text = text + sprintf("%8.2f", box.height);
        text = text + " 0";
    end

    text = text + " ";

end
