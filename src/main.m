% Main matlab script

%% Clear the console and environment
clear all
close all

%% Images Aquisition
addpath("./image_aquisition");
pedestrians=loadimages("../dataset/pedestrian/");
positives=loadimages("../dataset/images/pos/");
negatives=loadimages("../dataset/images/neg/");

%% Pre-processing TODO
addpath("./preprocessing");
pedestrians.images=preprocessing(pedestrians);
positives.images=preprocessing(positives);
negatives.images=preprocessing(negatives);

%% Segmentation TODO
addpath("./segmentation");
pedestrians.segmentated=segmentation(pedestrians);

%% Feature Extraction TODO
addpath("./features");
pedestrians.features=featureextraction(pedestrians);
positives.features=featureextraction(positives);
negatives.features=featureextraction(negatives);



