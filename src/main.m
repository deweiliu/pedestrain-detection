% Main matlab script

%% Clear the console and environment
clear all
close all

%% Images Aquisition
addpath("./image_aquisition");
pedestrians = loadimages("../dataset/pedestrian/");
positives = loadimages("../dataset/images/pos/");
negatives = loadimages("../dataset/images/neg/");

%% Pre-processing TODO
addpath("./preprocessing");
pedestrians.images = preprocessing(pedestrians);
positives.images = preprocessing(positives);
negatives.images = preprocessing(negatives);

%% Segmentation TODO
addpath("./segmentation");
pedestrians.segmentated = segmentation(pedestrians,true);

%% Feature Extraction TODO
addpath("./features");
pedestrians.features = featureextraction(pedestrians);
positives.features = featureextraction(positives);
negatives.features = featureextraction(negatives);

%% Classification TODO
addpath("./classification");
model = train(positives, negatives);
% Comment out whichever you don't need

% Predicting based on sampled training data
% Combine positives and negatives
combined.features = [positives.features;negatives.features];
combined.labels = [ones(positives.number,1);zeros(negatives.number,1)].';
% Randomly sample from combined
sampleIndexes = randsample(1:length(combined.features), 100);
sample.features = combined.features(sampleIndexes);
sample.labels = combined.labels(sampleIndexes);
sample.number = length(sample.features);
sample.result = test(sample, model);

% Predicting based on test data
% pedestrians.result = test(pedestrians, model);

comparison = (sample.labels==sample.result);
Accuracy = sum(comparison)/length(comparison)

%% presenting the result TODO
addpath("./presentation");
present(pedestrians);
