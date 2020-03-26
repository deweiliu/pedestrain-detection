% Script to compare classifiers

%% Set up Environment
setupEnvir;
%% parameters
OUTPUT_DIR = fullfile(output, "classifier_comparison");

makedir(OUTPUT_DIR);

%% Training images Pre-processing
positives = preprocessing(positives);
negatives = preprocessing(negatives);

%% Feature Extraction on training set
allFeatures = featureExtraction(positives, negatives);
features = allFeatures.HOG(:, 3:end);
labels = allFeatures.HOG(:, 1);
labels = logical(tableToArray(labels));

%% random forest model
% Tunning parameter
rfFigure = rfTunning(features, labels);
filePath = fullfile(OUTPUT_DIR, 'random_forest_param_tunning.svg');
saveas(rfFigure, filePath);
fprintf("RF graph saved at %s\n", filePath);

% Testing model
OPTIMISED_NUM_TREES = 30;
rfModel = randomForestTrain(features, labels, OPTIMISED_NUM_TREES);
predictions = rfTest(rfModel);
rfConfusion = confusionchart(labels, predictions);
title("Random Forest Confusion Matrix");
filePath = fullfile(OUTPUT_DIR, 'random_forest_confusion_matrix.svg');
saveas(rfConfusion, filePath);
fprintf("RF confusion matrix saved at %s\n", filePath);
