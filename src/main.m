% Main matlab script

%% Clear the console and environment
clear all
close all

%% Load the scripts from subfolders
% reference https://uk.mathworks.com/matlabcentral/answers/247180-how-may-i-add-all-subfolders-in-my-matlab-path
folder = fileparts(which(mfilename));
addpath(genpath(folder));

%% Images Aquisition
pedestrians = loadimages("../dataset/pedestrian/");
positives = loadimages("../dataset/images/pos/");
negatives = loadimages("../dataset/images/neg/");
positives.labels = ones(positives.number, 1);
negatives.labels = zeros(negatives.number, 1);
pedestrians.labels = zeros(pedestrians.number, 1) - 1;

%% Pre-processing TODO
pedestrians.images = preprocessing(pedestrians);
positives.images = preprocessing(positives);
negatives.images = preprocessing(negatives);

%% Feature Extraction on training set
features = featureExtraction(positives, negatives);

%% Fit the svm model using features generated by HOG
svmModel = svmTrain(features.HOG);
svmTest(svmModel);

%% Fit the knn model using features generated by HOG
knnModel = knnTrain(features.HOG, 5);
knnTest(knnModel);

%% Sliding windows
SLIDING_WIDTH = positives.nColumns;
SLIDING_HEIGHT = positives.nRows;
SLIDING_SCALES = [0.8, 1.2, 1.6, 2];
SLIDING_GAP_PERCENTAGE = 0.4; % 40 per cent
pedestrians.sliding = slidingwindows(pedestrians, SLIDING_WIDTH, SLIDING_HEIGHT, SLIDING_SCALES, SLIDING_GAP_PERCENTAGE);

%% Generating features for all testing images creating by sliding windows
pedestrians = featureExtractorPedestrians(pedestrians);

%% Making prediction on all testing images by fitted model (SVM KNN)
pedestrians = pedestriansPredictor(pedestrians, svmModel, knnModel);

%% Visualize human images
frame_index = 20; % It can be 1 to 100 corresponding which frame to visualize
visualizePrediction(pedestrians, frame_index)

%% Extract information of pedestrians
THRESHOLD = 2; % Greater or equal to 1, integer
LABELLING_CONNECTIVITY = 4; % 8 or 4  # See https://uk.mathworks.com/help/images/ref/bwlabel.html
pedestrians.results = informationExtraction(pedestrians, THRESHOLD, LABELLING_CONNECTIVITY);

%% presenting the result
% Re-run this block to rewatch the result %
FRAME_PER_SECOND = 5;
presentation(pedestrians, FRAME_PER_SECOND);
