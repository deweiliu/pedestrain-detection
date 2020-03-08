function features = featureextraction(object)
    % Add in label column
    headings = ["Label"];
    features = [object.labels];
        
    disp(fprintf('Generating colour histogram features...'))
    colourHistogramFeatures = colourHistogram(object, 8);
    features = [features, colourHistogramFeatures];
    % Generate colour histogram headings
    for i=1:size(colourHistogramFeatures, 2)
        headings = [headings, sprintf("colour_histogram_bin_%d", i)];
    end
    disp(fprintf('Finished generating colour histogram features.'))
    
    disp(fprintf('Generating HOG features...'))
    HOGfeatures = [];
    for i=1:size(object.paths,1)
        pos_image = imread(object.paths(i));
        [featureVector,~] = extractHOGFeatures(pos_image,'CellSize',[12,12]);
        HOGfeatures = [HOGfeatures;featureVector];
    end
    % Generate HOG headings
    for i=1:size(HOGfeatures, 2)
        headings = [headings, sprintf("HOG_feature_%d", i)];
    end
    features = [features, HOGfeatures];
    disp(fprintf('Finished generating HOG features.'))
        
    % Output as table
    features = array2table(features, 'VariableNames', headings);
    
    % To apply feature extraction on each sliding windows
    % img=pedestrians.slidingWindows(scaleIndex).slidingWindows(rowIndex,columnIndex,frameIndex).image;
    % imshow(img);
    % featureValues=featureExtractionFunction(img);
    % pedestrians.sliding(scaleIndex).windows(rowIndex,columnIndex,frameIndex).feature=featureValues;
end
