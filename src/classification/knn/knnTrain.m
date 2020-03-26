%% Reference
% https://uk.mathworks.com/help/stats/fitcknn.html
%% Parameters
% features(matrix) - the features table
% labels - class label
% K - int number
%% Returns
% model - the fitted model by KNN
function [model] = knnTrain(features,labels, K)
    fprintf('KNN model is training.\n');
    model = fitcknn(features, labels, 'NumNeighbors', K);
end
