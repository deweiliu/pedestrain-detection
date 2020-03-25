% Script to compare classifiers

%% Set up Environment
setupEnvir;
%% parameters
OUTPUT_DIR=fullfile(output,"classifier_comparison");

makedir(OUTPUT_DIR);

%% Training images Pre-processing
positives = preprocessing(positives);
negatives = preprocessing(negatives);

%% Feature Extraction on training set
features = featureExtraction(positives, negatives);

%% Parameter optimization on random forest model
rfFigure = rfTunning(features.HOG(:, 3:end), features.HOG(:, 1));
filePath=fullfile(OUTPUT_DIR, 'rfParaTuning.svg');
saveas(rfFigure, filePath);
fprintf("RF graph saved at %s",filePath);
