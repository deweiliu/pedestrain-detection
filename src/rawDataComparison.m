% Script to compare feature

%% Set up Environment
setupEnvir;

%% Constants for the script
GRAPHS_DIRECTORY = fullfile(output, "graphs");
makedir(GRAPHS_DIRECTORY);
RAW_DATA_ERROR_RATE_GRAPH_FILE = "raw_data_image_size_compare.svg";

%% Training images Pre-processing
positives = preprocessing(positives);
negatives = preprocessing(negatives);

%% Calculate accuracies for each quantization level for RGB and HSV histograms
% Set up metatable, containing labels and names of each image
metaTable = array2table([...
                        [positives.labels; positives.labels; negatives.labels; negatives.labels], ...
    [positives.paths; positives.paths; negatives.paths; negatives.paths] ...
    ], "VariableNames", ["Label", "Name"]);
metaTable.Label = str2double(metaTable.Label);

MAX_IMAGE_SIZE = 20;

rawDataErrorRate = [];

for i = 1:MAX_IMAGE_SIZE
    fprintf("Calculating features and crossvalidating accuracy for image size = %d * %d\n", i, i);
    features = generateOrLoadFeature(false, metaTable, positives, ...
        negatives, "", @rawData, {[i, i]});
    accuracy = crossValidatedAccuracy(@svmTrain, features, 5);
    totalCorrect = accuracy{1, 1} + accuracy{2, 2};
    total = totalCorrect + accuracy{1, 2} + accuracy{2, 1};
    rawDataErrorRate = [rawDataErrorRate; [i, 1 - totalCorrect / total]];
end

rawDataErrorRate = array2table(rawDataErrorRate, "VariableNames", ["Image Size", "Error Rate"]);

%% Present accuracy comparisons

rgbFig = figure;
plot(rawDataErrorRate{:, 1}, rawDataErrorRate{:, 2});
title("Raw Data Error Rate against Image Size");
xlabel("Image Size");
ylabel("Error Rate");
saveas(rgbFig, sprintf("%s/%s", GRAPHS_DIRECTORY, RAW_DATA_ERROR_RATE_GRAPH_FILE), "svg");
