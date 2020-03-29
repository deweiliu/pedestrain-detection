% Main matlab script

%% Section 1. Set up Environment
setupEnvir;

%% Section 2. Training images Pre-processing
positives = preprocessing(positives);
negatives = preprocessing(negatives);

%% Section 3. Feature Extraction on training set
features = featureExtraction(positives, negatives, output);

%% Section 4. Train svm model
svmModel = svmTrain(features.HOG);
% compactSvmModel = compact(svmModel);
scoreSvmModel = fitPosterior(svmModel);

%% Section 5. Generate sliding windows
SLIDING_WIDTH = positives.nColumns;
SLIDING_HEIGHT = positives.nRows;
SLIDING_SCALES = [0.6, 1.0, 1.4, 1.8, 2.2, 2.6];
SLIDING_GAP_PERCENTAGE = 0.3; % 20 per cent
pedestrians.sliding = slidingwindows(pedestrians, SLIDING_WIDTH, SLIDING_HEIGHT, SLIDING_SCALES, SLIDING_GAP_PERCENTAGE);

%% Section 6. Generating features for all sliding windows in testing images
pedestrians = featureExtractorPedestrians(pedestrians);
labelName = "label_HOG_SVM"; % The label to be used in predictor

%% Section 7. Classify/predict the sliding windows in testing images
pedestrians = pedestriansPredictor(pedestrians, scoreSvmModel, labelName);
% save("pedestrians.mat", 'pedestrians');

%% Section 8. Given all the proposals of sliding windows, select the ones in final result
result = proposalFilter(pedestrians, labelName);
save("result.mat", 'result');

%% Section 9. Evaluate and present the result
evaluationResult;

