function [model] = knnTrain(features)
    % First col is the label, second col is the name
    labels = features(:,1);
    % The rest is feature info
    featureData = features(:,3:end);
    
    model.Features = featureData;
    model.Labels = labels;
end

