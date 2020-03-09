%% Reference
% https://uk.mathworks.com/help/stats/fitcsvm.html
%% Parameters
% features(matrix) - the features matrix
%% Returns
% model - the fitted model by svm
function [model] = svmtrain(features)
% first col is the label, second col is the name
Labels = features(:,1);
% the rest is feature info
feature_data = features(:,3:end);
model = fitcsvm(feature_data,Labels,'KernelFunction','linear');
end
