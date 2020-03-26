%% Reference
% https://uk.mathworks.com/help/stats/fitcsvm.html
%% Parameters
% features(matrix) - the features matrix
%% Returns
% model - the fitted model by svm
function [model] = svmTrain(features)
    fprintf('SVM model is training.\n');
    % first col is the label, second col is the name
    labels = features(:,1);
    % the rest is feature info
    featureData = features(:,3:end);
    model = fitcsvm(featureData, labels, 'KernelFunction','linear',...
        'BoxConstraint',1.2541, 'KernelScale', 0.3364);
end
