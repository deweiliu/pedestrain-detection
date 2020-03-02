%% Reference
% https://uk.mathworks.com/help/stats/fitcsvm.html
function [model] = svm_train(features)
%model: the fitted model by svm
%  using all image to fit the svm model

% first col is the label
Labels = features(:,1);
% the rest is feature info
feature_data = features(:,2:end);
model = fitcsvm(feature_data,Labels);
end
