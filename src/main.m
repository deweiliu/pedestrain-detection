% Main matlab script

%% Set up Environment
setupEnvir;

%% Training images Pre-processing
positives = preprocessing(positives);
negatives = preprocessing(negatives);

%% TO BE MOVED to a separate script
% Visualize processing images
IMAGE_INDEX = 1;
% If parameter is positives, IMAGE_INDEX must not exceed 2003.
% If parameter is negatives, IMAGE_INDEX must not exceed 997.
visualizeProcessingImages(positives, IMAGE_INDEX, output);

%% Feature Extraction on training set
features = featureExtraction(positives, negatives, output);

%% train svm model
svmModel = svmTrain(features.HOG);
% compactSvmModel = compact(svmModel);
scoreSvmModel = fitPosterior(svmModel);

%% Generate sliding windows
SLIDING_WIDTH = positives.nColumns;
SLIDING_HEIGHT = positives.nRows;
SLIDING_SCALES = [0.8, 1.2, 1.6, 2.0];
SLIDING_GAP_PERCENTAGE = 0.4; % 40 per cent
pedestrians.sliding = slidingwindows(pedestrians, SLIDING_WIDTH, SLIDING_HEIGHT, SLIDING_SCALES, SLIDING_GAP_PERCENTAGE);

%% Generating features for all sliding windows in testing images
pedestrians = featureExtractorPedestrians(pedestrians);
labelName = "label_HOG_SVM"; % The label to be used in predictor

%% Classify/predict the sliding windows in testing images
pedestrians = pedestriansPredictor(pedestrians, scoreSvmModel, labelName);

%% Given all the proposals of sliding windows, select the ones in final result
result = proposalFilter(pedestrians, labelName);
save("result.mat", 'result');

%% TO BE MOVED to a separate script
%Visualize sliding windows images which are predicted as positive
FRAME_INDEX = 3; % It can be 1 to 100 corresponding which frame to visualize
visualizePrediction(pedestrians, FRAME_INDEX, output);

%% evalute and present the result
evaluationResult;
