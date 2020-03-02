%% Clear the console and environment
clear all
close all

%% Images Aquisition
addpath("./image_aquisition");
positives = loadimages("../dataset/images/pos/");
negatives = loadimages("../dataset/images/neg/");
positives.labels = ones(positives.number, 1);
negatives.labels = zeros(negatives.number, 1);

%% Pre-processing TODO
addpath("./preprocessing");
positives.images = preprocessing(positives);
negatives.images = preprocessing(negatives);

%% Feature Extraction TODO
addpath("./features");
positives.features = featureextraction(positives);
negatives.features = featureextraction(negatives);

%% Add classifiers to path and split testing and training samples
addpath("./classification");

combined.features = [positives.features; negatives.features];
combined.labels = [positives.labels; negatives.labels];

testingIndexes = randsample(1:length(combined.features), ceil(length(combined.features) * 0.20));
testing.features = combined.features(testingIndexes);
testing.labels = combined.labels(testingIndexes);

training.features = combined.features;
training.features(testingIndexes) = [];
training.labels = combined.labels;
training.labels(testingIndexes) = [];

positiveTraining.features = training.features(training.labels == 1);
positiveTraining.labels = training.labels(training.labels == 1);
negativeTraining.features = training.features(training.labels == 0);
negativeTraining.labels = training.labels(training.labels == 0);

%% 1->20-NN
nnAccuracies = zeros(20, 1);
for i=1:20
    model = knntrain(positiveTraining, negativeTraining);
    testing.result = knntest(testing, model, i);

    nnAccuracies(i, 1) = sum(testing.result == testing.labels) / length(testing.result);
end
nnAccuracies
%% SVM
