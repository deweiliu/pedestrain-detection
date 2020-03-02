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

%% Feature Extraction TODO
addpath("./features");
features_HOG = featuregenreator_HOG(positives, negatives);

%% Pre-processing TODO
% addpath("./preprocessing");
% pedestrians.images = preprocessing(pedestrians);
% positives.images = preprocessing(positives);
% negatives.images = preprocessing(negatives);

%% Segmentation TODO
% addpath("./segmentation");
% pedestrians.segmentated = segmentation(pedestrians, true);

%% Classification TODO
addpath("./classification");
svm_model_HOG = svm_train(features_HOG);
svm_test(svm_model_HOG);

%% presenting the result TODO
% addpath("./presentation");
% present(pedestrians);
