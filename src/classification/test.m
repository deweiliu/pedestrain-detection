function result=test(pedestrians, model)
    result = knntest(pedestrians, model, 1);
    
        
    % To feed the feature values of each sliding window to the classifer
    % featureValues=pedestrians.slidingWindows(scaleIndex).slidingWindows(rowIndex,columnIndex,frameIndex).feature;    
    % true or false =classifier(featureValues,model);
    % pedestrians.slidingWindows(scaleIndex).slidingWindows(rowIndex,columnIndex,frameIndex).isHuman= true or false;
end