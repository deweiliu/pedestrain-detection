function [] = svmParaTuning(features)
    fprintf('SVM model parameters optimization is running.\n');
    % first col is the label, second col is the name
    labels = features(:,1);
    % the rest is feature info
    featureData = features(:,3:end);
    
    % detect which kernel function is the most appropriate one
    fprintf('Fitting SVM model using linear as Kernel function.\n');
    tic
    rng(3064)
    model = fitcsvm(featureData, labels,'Standardize',true,'KernelFunction','linear',...
    'KernelScale','auto');
    svmTest(model)
    toc
    
    fprintf('Fitting SVM model using RBF as Kernel function.\n');
    tic
    rng(3064)
    model = fitcsvm(featureData, labels,'Standardize',true,'KernelFunction','rbf',...
    'KernelScale','auto');
    svmTest(model)
    toc
    
    fprintf('Fitting SVM model using Gaussian as Kernel function.\n');
    tic
    rng(3064)
    model = fitcsvm(featureData, labels,'Standardize',true,'KernelFunction','gaussian',...
    'KernelScale','auto');
    svmTest(model)
    toc
    
    fprintf('Fitting SVM model using Polynomial as Kernel function.\n');
    tic
    rng(3064)
    model = fitcsvm(featureData, labels,'Standardize',true,'KernelFunction','polynomial',...
    'KernelScale','auto');
    svmTest(model)
    toc
end

