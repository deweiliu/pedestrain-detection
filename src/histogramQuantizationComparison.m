% Script to compare feature

%% Set up Environment
setupEnvir;

%% Constants for the script
GRAPHS_DIRECTORY = "../graphs";
RGB_ERROR_RATE_GRAPH_FILE = "rgb_error_rate_quantization_compare.svg";
HSV_ERROR_RATE_GRAPH_FILE = "hsv_error_rate_quantization_compare.svg";

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

MAX_QUANTIZATION_VALUE = 30;

rgbErrorRate = [];

for i = 1:MAX_QUANTIZATION_VALUE
    fprintf("Calculating features and crossvalidating accuracy for quantization level = %d\n", i);
    features = generateOrLoadFeature(false, metaTable, positives, ...
        negatives, "", @colourHistogramRGB, {i});
    accuracy = crossValidatedAccuracy(@svmTrain, features, 5);
    totalCorrect = accuracy{1, 1} + accuracy{2, 2};
    total = totalCorrect + accuracy{1, 2} + accuracy{2, 1};
    rgbErrorRate = [rgbErrorRate; [i, 1 - totalCorrect / total]];
end

rgbErrorRate = array2table(rgbErrorRate, "VariableNames", ["Quantization Level", "Error Rate"]);

hsvErrorRate = [];

for i = 1:MAX_QUANTIZATION_VALUE
    fprintf("Calculating features and crossvalidating accuracy for quantization level = %d\n", i);
    features = generateOrLoadFeature(false, metaTable, positives, ...
        negatives, "", @colourHistogramHSV, {i});
    accuracy = crossValidatedAccuracy(@svmTrain, features, 5);
    totalCorrect = accuracy{1, 1} + accuracy{2, 2};
    total = totalCorrect + accuracy{1, 2} + accuracy{2, 1};
    hsvErrorRate = [hsvErrorRate; [i, 1 - totalCorrect / total]];
end

hsvErrorRate = array2table(hsvErrorRate, "VariableNames", ["Quantization Level", "Error Rate"]);

%% Present accuracy comparisons

rgbFig = figure;
plot(rgbErrorRate{:, 1}, rgbErrorRate{:, 2});
title("RGB Colour Histogram Error Rate against Quantization Level");
xlabel("Quantization Level");
ylabel("Error Rate");
saveas(rgbFig, sprintf("%s/%s", GRAPHS_DIRECTORY, RGB_ERROR_RATE_GRAPH_FILE), "svg");

hsvFig = figure;
plot(hsvErrorRate{:, 1}, hsvErrorRate{:, 2});
title("HSV Colour Histogram Error Rate against Quantization Level");
xlabel("Quantization Level");
ylabel("Error Rate");
saveas(hsvFig, sprintf("%s/%s", GRAPHS_DIRECTORY, HSV_ERROR_RATE_GRAPH_FILE), "svg");
