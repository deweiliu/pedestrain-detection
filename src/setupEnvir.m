%% Clear the console and environment
clear all
close all

%% Load the scripts from subfolders
% reference https://uk.mathworks.com/help/matlab/ref/genpath.html
paths = genpath("./");
addpath(paths);

%% Create output directory
output = "../output";

makedir(output);

%% Images Aquisition
pedestrians = loadImages("../dataset/pedestrian/");
positives = loadImages("../dataset/images/pos/");
negatives = loadImages("../dataset/images/neg/");
positives.labels = ones(positives.number, 1);
negatives.labels = zeros(negatives.number, 1);
pedestrians.labels = zeros(pedestrians.number, 1) - 1;
