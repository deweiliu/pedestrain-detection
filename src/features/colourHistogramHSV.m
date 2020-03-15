function [result] = colourHistogramHSV(img, quantizationColors)
    % Perform quantization to reduce feature count
    [imgQ, map] = rgb2ind(img, quantizationColors, 'nodither');
    imgQ = ind2rgb(imgQ, map);
    imgQ = rgb2hsv(imgQ);

    % Get HSV values
    h = imgQ(:,:,1);
    s = imgQ(:,:,2);
    v = imgQ(:,:,3); 

    % Get histogram values for each channel
    hueHist = imhist(h, quantizationColors)./numel(h);
    satHist = imhist(s, quantizationColors)./numel(s);
    valHist = imhist(v, quantizationColors)./numel(v);
    result = [hueHist.', satHist.', valHist.'];
end

