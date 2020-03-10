function features = featureExtraction(positives, negatives)
    FEATURES_DIRECTORY = "../dataset/features_datasets";
    COLOUR_HISTOGRAM_FILE = "colour_histogram_feature.csv";
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
    
    % Colour Histogram
    features.ColourHistogram = [];
    if ~exist(sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_FILE), "file") == 0
        disp(fprintf('Found Colour Histogram feature file, skipping generation and loading from file'));
        features.ColourHistogram = readtable(sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_FILE));
    else
        disp(fprintf('No Colour Histogram feature file found, generating a new one'));
        disp(fprintf('Generating features for positive data'));
        for i=1:length(positives.images)
            image = positives.images(:,:,:,i);
            features.ColourHistogram = [features.ColourHistogram; colourHistogram(image, 16)];
        end
        disp(fprintf('Generating features for negative data'));
        for i=1:length(negatives.images)
            image = negatives.images(:,:,:,i);
            features.ColourHistogram = [features.ColourHistogram; colourHistogram(image, 16)];
        end
        
        % Convert to table
        features.ColourHistogram = array2table(features.ColourHistogram);
        
        % Add metadata (labels and image names)
        features.ColourHistogram = [metaTable, features.ColourHistogram];
        
        disp(fprintf('Saving Colour Histogram feature file...'));
        writetable(features.ColourHistogram, sprintf("%s/%s", FEATURES_DIRECTORY, COLOUR_HISTOGRAM_FILE));
        disp(fprintf('Finished saving Colour Histogram feature file'));
    end
    
    % Build combined features
    features.Combined = join(features.HOG, features.ColourHistogram, "Keys", "Name", "KeepOneCopy", "Label");
    
    % Shuffle features
    rng(3064);
    features.Combined = features.Combined(randperm(size(features.Combined,1)),:);
    features.HOG = features.HOG(randperm(size(features.HOG,1)),:);
    features.ColourHistogram = features.ColourHistogram(randperm(size(features.ColourHistogram,1)),:);
end
