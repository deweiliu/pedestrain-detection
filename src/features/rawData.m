function [result] = rawData(img, dimensions)
    imgResized = imresize(img, dimensions);
    result = imgResized(:).';
end

