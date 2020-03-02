function [features] = featuregenreator_HOG(positives, negatives)
% generating features files
features = [];
% check the existance of features files folder
if exist('../dataset/features_datasets','dir')==0
    mkdir('../dataset/features_datasets');
end

% reading features generated by HOG
if ~exist('../dataset/features_datasets/features_HOG_cellsize_12_12.csv','file')==0
    features = readtable('../dataset/features_datasets/features_HOG_cellsize_12_12.csv');
else
    for i=1:size(positives.paths,1)
        pos_image = imread(positives.paths(i));
        [featureVector,~] = extractHOGFeatures(pos_image,'CellSize',[12,12]);
        features = [features;featureVector];
    end
    
    for i=1:size(negatives.paths,1)
        neg_image = imread(negatives.paths(i));
        [featureVector,~] = extractHOGFeatures(neg_image,'CellSize',[12,12]);
        features = [features;featureVector];
    end
    allLabels = [positives.labels; negatives.labels];
    
    % reformat the training data
    features = array2table(features);
    allLabels = array2table(allLabels, 'VariableNames',{'Labels'});
    features = [allLabels,features];
    
    % shuffle the data
    rng(3064);
    features = features(randperm(size(features,1)),:);
    
    disp('saving features generated by HOG as csv file.')
    writetable(features, '../dataset/features_datasets/features_HOG_cellsize_12_12.csv')
    disp('end.')
end
end

