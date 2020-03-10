%% Reference
% https://uk.mathworks.com/help/stats/fitcknn.html
%% Parameters
% features(matrix) - the features table
%% Returns
% model - the fitted model by KNN
function [model] = knnTrain(features, K)
    disp(fprintf('KNN model is training.'))
    % First col is the label, second col is the name
    labels = features(:,1);
    % The rest is feature info
    featureData = features(:,3:end);
    model = fitcknn(featureData, labels, 'NumNeighbors', K);
end
