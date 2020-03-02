% Main matlab script

%% Clear the console and environment
clear all
close all

%% Images Aquisition
addpath("./image_aquisition");
pedestrians = loadimages("../dataset/pedestrian/");
positives = loadimages("../dataset/images/pos/");
negatives = loadimages("../dataset/images/neg/");
positives.labels = ones(positives.number, 1);
negatives.labels = zeros(negatives.number, 1);

%% Pre-processing TODO
addpath("./preprocessing");
pedestrians.images = preprocessing(pedestrians);
positives.images = preprocessing(positives);
negatives.images = preprocessing(negatives);

%% Segmentation TODO
addpath("./segmentation");
pedestrians.segmentated = segmentation(pedestrians, true);

%% Feature Extraction TODO
addpath("./features");
pedestrians.features = featureextraction(pedestrians);
positives.features = featureextraction(positives);
negatives.features = featureextraction(negatives);

%% Classification TODO
addpath("./classification");
model = train(positives, negatives);
pedestrians.result = test(pedestrians, model);

%% presenting the result TODO
addpath("./presentation");
present(pedestrians);
