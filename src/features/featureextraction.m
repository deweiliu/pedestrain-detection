function features = featureextraction(object)
    % Placeholder random numbers between 1 -> 10000
    features = [];
    features = [features,randi(10000, object.number, 1)];
    
    % To apply feature extraction on each sliding windows
    % img=pedestrians.slidingWindows(scaleIndex).slidingWindows(rowIndex,columnIndex,frameIndex).image;
    % imshow(img);
    % featureValues=featureExtractionFunction(img);
    % pedestrians.slidingWindows(scaleIndex).slidingWindows(rowIndex,columnIndex,frameIndex).feature=featureValues;
end
