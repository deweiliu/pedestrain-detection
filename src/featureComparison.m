% Script to compare feature

%% Clear the console and environment
clear all
close all

%% Load the scripts from subfolders
% reference https://uk.mathworks.com/help/matlab/ref/genpath.html
paths=genpath("./");
addpath(paths);

%% Images Aquisition
positives = loadimages("../dataset/images/pos/");
negatives = loadimages("../dataset/images/neg/");
positives.labels = ones(positives.number, 1);
negatives.labels = zeros(negatives.number, 1);

%% Training images Pre-processing 
positives = preprocessing(positives);
negatives = preprocessing(negatives);

%% Feature Extraction on training set
features = featureExtraction(positives, negatives);

%% Calculate cross validated accuracies
errorRates = [];
featureNames = fieldnames(features);

fprintf("Calculating features and crossvalidating accuracy for all features\n");
combined = [];
for i=1:numel(featureNames)
    extractedFeatures = features.(featureNames{i});
    if isempty(combined)
        combined = extractedFeatures;
    else
        combined = join(combined, extractedFeatures, "Keys", "Name", "KeepOneCopy", "Label");
    end
end
accuracy = crossValidatedAccuracy(@svmTrain, combined, 5);
totalCorrect = accuracy{1,1} + accuracy{2,2};
total = totalCorrect + accuracy{1,2} + accuracy{2,1};
errorRates = [errorRates; [1 - totalCorrect/total, ...
    accuracy{1,1}, accuracy{1,2}, accuracy{2,1}, accuracy{2,2}]];

for i=1:numel(featureNames)
    fprintf("Calculating features and crossvalidating accuracy for all features except = %s\n", featureNames{i});
    combined = [];
    for j=1:numel(featureNames)
        if i == j
            continue
        end
        extractedFeatures = features.(featureNames{j});
        if isempty(combined)
            combined = extractedFeatures;
        else
            combined = join(combined, extractedFeatures, "Keys", "Name", "KeepOneCopy", "Label");
        end
    end
    accuracy = crossValidatedAccuracy(@svmTrain, combined, 5);
    totalCorrect = accuracy{1,1} + accuracy{2,2};
    total = totalCorrect + accuracy{1,2} + accuracy{2,1};
    errorRates = [errorRates; [1 - totalCorrect/total, ...
        accuracy{1,1}, accuracy{1,2}, accuracy{2,1}, accuracy{2,2}]];
end

featureNames = cell2table([{"None"}; featureNames], "VariableNames", ["Feature Removed"]);
errorRates = array2table(errorRates, "VariableNames", ...
    ["Error Rate", "True Pedestrian", "False No Pedestrian", "False Pedestrian", "True No Pedestrian"]);
errorRates = [featureNames,errorRates];

%% Calculate error rate diff
errorRatesDiff = errorRates;

for i=2:height(errorRatesDiff)
    errorRatesDiff{i, 2} = errorRatesDiff{i, 2} - errorRatesDiff{1, 2};
    errorRatesDiff{i, 3} = errorRatesDiff{i, 3} - errorRatesDiff{1, 3};
    errorRatesDiff{i, 4} = errorRatesDiff{i, 4} - errorRatesDiff{1, 4};
    errorRatesDiff{i, 5} = errorRatesDiff{i, 5} - errorRatesDiff{1, 5};
    errorRatesDiff{i, 6} = errorRatesDiff{i, 6} - errorRatesDiff{1, 6};
end
