function [result] = colourHistogram(data, quantizationColors)
    result = [];
    for i=1:data.number
        rgb = data.images(:,:,:,i);
        
        % Perform quantization to reduce feature count
        [imgQ, map] = rgb2ind(rgb, quantizationColors, 'nodither');
        imgQ = ind2rgb(imgQ, map);
                
        % Get RGB values
        r = imgQ(:,:,1);
        g = imgQ(:,:,2);
        b = imgQ(:,:,3); 

        % Get histogram values for each colour
        redHist = imhist(r, quantizationColors);
        greenHist = imhist(g, quantizationColors);
        blueHist = imhist(b, quantizationColors);
        hist = [redHist.', greenHist.', blueHist.'];
        result = [result; hist];
    end
    [rows, columns] = size(result);
    headings = [];
    for i=1:columns
        headings = [headings, sprintf("colour_histogram_bin_%d", i)];
    end
    result = [headings; result];
end

