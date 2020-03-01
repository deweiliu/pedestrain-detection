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
pedestrians.images=preprocessing(pedestrians.images);
positives.images=preprocessing(positives.images);
negatives.images=preprocessing(negatives.images);
