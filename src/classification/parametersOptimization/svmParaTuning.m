function [] = svmParaTuning(features)
    fprintf('SVM model parameters optimization is running.\n');
    % first col is the label, second col is the name
    labels = features(:,1);
    % the rest is feature info
    featureData = features(:,3:end);
    % setting OptimizeHyperparameters
    model = fitcsvm(featureData, labels,'KernelFunction','linear',...
        'OptimizeHyperparameters',{'BoxConstraint','KernelScale'},...
        'HyperparameterOptimizationOptions',struct('ShowPlots',false));
end

