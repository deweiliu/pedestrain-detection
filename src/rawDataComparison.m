% Script to compare feature

%% Clear the console and environment
clear all
close all

%% Constants for the script
GRAPHS_DIRECTORY = "../graphs";
RAW_DATA_ERROR_RATE_GRAPH_FILE = "raw_data_image_size_compare.svg";

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

%% Calculate accuracies for each quantization level for RGB and HSV histograms
% Set up metatable, containing labels and names of each image
metaTable = array2table([...
    [positives.labels;positives.labels;negatives.labels;negatives.labels], ...
    [positives.paths;positives.paths;negatives.paths;negatives.paths] ...
], "VariableNames", ["Label", "Name"]);
metaTable.Label = str2double(metaTable.Label);

MAX_IMAGE_SIZE = 20;

rawDataErrorRate = [];

for i=1:MAX_IMAGE_SIZE
    fprintf("Calculating features and crossvalidating accuracy for image size = %d * %d\n", i, i);
    features = generateOrLoadFeature(false, metaTable, positives, ...
        negatives, "", @rawData, {[i, i]});
    accuracy = crossValidatedAccuracy(@svmTrain, features, 5);
    totalCorrect = accuracy{1,1} + accuracy{2,2};
    total = totalCorrect + accuracy{1,2} + accuracy{2,1};
    rawDataErrorRate = [rawDataErrorRate;[i, 1 - totalCorrect/total]];
end

rawDataErrorRate = array2table(rawDataErrorRate, "VariableNames", ["Image Size", "Error Rate"]);

%% Present accuracy comparisons

rgbFig = figure;
plot(rawDataErrorRate{:,1}, rawDataErrorRate{:,2});
title("Raw Data Error Rate against Image Size");
xlabel("Image Size");
ylabel("Error Rate");
saveas(rgbFig, sprintf("%s/%s", GRAPHS_DIRECTORY, RAW_DATA_ERROR_RATE_GRAPH_FILE), "svg");

