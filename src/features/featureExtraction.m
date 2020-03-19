function features = featureExtraction(positives, negatives)
    FEATURES_DIRECTORY = "../dataset/features_datasets";
    COLOUR_HISTOGRAM_RGB_FILE = "colour_histogram_rgb_feature.csv";
    COLOUR_HISTOGRAM_HSV_FILE = "colour_histogram_hsv_feature.csv";
    RAW_DATA_FILE = "raw_data_feature.csv";
    HOG_FILE = "hog_feature.csv";
    
    % Set up metatable, containing labels and names of each image
    metaTable = array2table([...
        [positives.labels;positives.labels;negatives.labels;negatives.labels], ...
        [positives.paths;positives.paths;negatives.paths;negatives.paths] ...
    ], "VariableNames", ["Label", "Name"]);
    metaTable.Label = str2double(metaTable.Label);
        
    % Check the existance of features files folder
    if exist(FEATURES_DIRECTORY,'dir') == 0
        disp(fprintf("path: %s does not exist.\nCreating one.", FEATURES_DIRECTORY));
        mkdir(FEATURES_DIRECTORY); 
    end
    
    % HOG
    features.HOG = generateOrLoadFeature(metaTable, positives, negatives, ...
        sprintf("%s/%s", FEATURES_DIRECTORY, HOG_FILE),@histogramOfOrientedGradients, {});
    
    % Colour Histogram RGB
    features.ColourHistogramRGB = generateOrLoadFeature(metaTable, positives, negatives, ...
        sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_RGB_FILE),@colourHistogramRGB, {16});
   
    % Colour Histogram HSV
    features.ColourHistogramHSV = generateOrLoadFeature(metaTable, positives, negatives, ...
        sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_HSV_FILE),@colourHistogramHSV, {16});
    
    % Raw Data
    features.RawData = generateOrLoadFeature(metaTable, positives, negatives, ...
        sprintf("%s/%s", FEATURES_DIRECTORY, RAW_DATA_FILE),@rawData, {[32,32]});
        
    % Shuffle features
    rng(3064);
    features.HOG = features.HOG(randperm(size(features.HOG,1)),:);
    features.ColourHistogramRGB = features.ColourHistogramRGB(randperm(size(features.ColourHistogramRGB,1)),:);
    features.ColourHistogramHSV = features.ColourHistogramHSV(randperm(size(features.ColourHistogramHSV,1)),:);
    features.RawData = features.RawData(randperm(size(features.RawData,1)),:);
end
