function features = featureExtraction(positives, negatives)
    FEATURES_DIRECTORY = "../dataset/features_datasets";
    COLOUR_HISTOGRAM_RGB_FILE = "colour_histogram_rgb_feature.csv";
    COLOUR_HISTOGRAM_HSV_FILE = "colour_histogram_hsv_feature.csv";
    HOG_FILE = "hog_feature.csv";
    
    % Set up metatable, containing labels and names of each image
    metaTable = array2table([...
        [positives.labels;negatives.labels], ...
        [positives.paths;negatives.paths] ...
    ], "VariableNames", ["Label", "Name"]);
    
    % Check the existance of features files folder
    if exist(FEATURES_DIRECTORY,'dir') == 0
        disp(fprintf("path: %s does not exist.\nCreating one.", FEATURES_DIRECTORY));
        mkdir(FEATURES_DIRECTORY); 
    end
    
    % HOG
    features.HOG = [];
    if ~exist(sprintf("%s/%s", FEATURES_DIRECTORY, HOG_FILE), "file") == 0
        disp(fprintf('Found HOG feature file, skipping generation and loading from file'));
        features.HOG = readtable(sprintf("%s/%s", FEATURES_DIRECTORY, HOG_FILE));
    else
        disp(fprintf('No HOG feature file found, generating a new one'));
        disp(fprintf('Generating features for positive data'));
        for i=1:length(positives.images)
            image = positives.images(:,:,:,i);
            features.HOG = [features.HOG; histogramOfOrientedGradients(image)];
        end
        disp(fprintf('Generating features for negative data'));
        for i=1:length(negatives.images)
            image = negatives.images(:,:,:,i);
            features.HOG = [features.HOG; histogramOfOrientedGradients(image)];
        end
        
        % Convert to table
        features.HOG = array2table(features.HOG);
        
        % Add metadata (labels and image names)
        features.HOG = [metaTable, features.HOG];
        
        disp(fprintf('Saving HOG feature file...'));
        writetable(features.HOG, sprintf("%s/%s", FEATURES_DIRECTORY, HOG_FILE));
        disp(fprintf('Finished saving HOG feature file'));
    end
    
    % Colour Histogram RGB
    features.ColourHistogramRGB = [];
    if ~exist(sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_RGB_FILE), "file") == 0
        disp(fprintf('Found Colour Histogram RGB feature file, skipping generation and loading from file'));
        features.ColourHistogramRGB = readtable(sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_RGB_FILE));
    else
        disp(fprintf('No Colour Histogram RGB feature file found, generating a new one'));
        disp(fprintf('Generating features for positive data'));
        for i=1:length(positives.images)
            image = positives.images(:,:,:,i);
            features.ColourHistogramRGB = [features.ColourHistogramRGB; colourHistogramRGB(image, 16)];
        end
        disp(fprintf('Generating features for negative data'));
        for i=1:length(negatives.images)
            image = negatives.images(:,:,:,i);
            features.ColourHistogramRGB = [features.ColourHistogramRGB; colourHistogramRGB(image, 16)];
        end
        
        % Convert to table
        features.ColourHistogramRGB = array2table(features.ColourHistogramRGB);
        
        % Add metadata (labels and image names)
        features.ColourHistogramRGB = [metaTable, features.ColourHistogramRGB];
        
        disp(fprintf('Saving Colour Histogram RGB feature file...'));
        writetable(features.ColourHistogramRGB, sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_RGB_FILE));
        disp(fprintf('Finished saving Colour Histogram RGB feature file'));
    end
    
    % Colour Histogram HSV
    features.ColourHistogramHSV = [];
    if ~exist(sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_HSV_FILE), "file") == 0
        disp(fprintf('Found Colour Histogram RGB feature file, skipping generation and loading from file'));
        features.ColourHistogramHSV = readtable(sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_HSV_FILE));
    else
        disp(fprintf('No Colour Histogram HSV feature file found, generating a new one'));
        disp(fprintf('Generating features for positive data'));
        for i=1:length(positives.images)
            image = positives.images(:,:,:,i);
            features.ColourHistogramHSV = [features.ColourHistogramHSV; colourHistogramHSV(image, 16)];
        end
        disp(fprintf('Generating features for negative data'));
        for i=1:length(negatives.images)
            image = negatives.images(:,:,:,i);
            features.ColourHistogramHSV = [features.ColourHistogramHSV; colourHistogramHSV(image, 16)];
        end
        
        % Convert to table
        features.ColourHistogramHSV = array2table(features.ColourHistogramHSV);
        
        % Add metadata (labels and image names)
        features.ColourHistogramHSV = [metaTable, features.ColourHistogramHSV];
        
        disp(fprintf('Saving Colour Histogram HSV feature file...'));
        writetable(features.ColourHistogramHSV, sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_HSV_FILE));
        disp(fprintf('Finished saving Colour Histogram HSV feature file'));
    end
        
    % Shuffle features
    rng(3064);
    features.HOG = features.HOG(randperm(size(features.HOG,1)),:);
    features.ColourHistogramRGB = features.ColourHistogramRGB(randperm(size(features.ColourHistogramRGB,1)),:);
end
