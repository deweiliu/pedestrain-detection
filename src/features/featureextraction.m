function features = featureextraction(object)
    % Add in label column
    headings = ["Label"];
    features = [object.labels];
    
    % Add in colour histogram results
    colourHistogramResult = colourHistogram(object, 8);
    headings = [headings, colourHistogramResult(1,:)];
    features = [features, colourHistogramResult(2:end,:)];
    
    % Convert table to numerical
    features = str2double(features);
    % Output as table
    features = array2table(features, 'VariableNames', headings);
    
    % To apply feature extraction on each sliding windows
    % img=pedestrians.slidingWindows(scaleIndex).slidingWindows(rowIndex,columnIndex,frameIndex).image;
    % imshow(img);
    % featureValues=featureExtractionFunction(img);
    % pedestrians.sliding(scaleIndex).windows(rowIndex,columnIndex,frameIndex).feature=featureValues;
end
