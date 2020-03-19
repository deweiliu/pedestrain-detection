%% Evaluate processing images, to see which one can improve performance of model
function [] = processingImagesSelection(positives, negatives)
sampleSize = 350;

posLabels = positives.labels(1:sampleSize,:);
negLabels = negatives.labels(1:sampleSize,:);
posOriIamgeSample = positives.images(:,:,:,1:sampleSize);
negOriIamgeSample = negatives.images(:,:,:,1:sampleSize);

% contrast enhanced
posSample1 = positives.processedImages.contrastingImages(:,:,:,1:sampleSize);
negSample1 = negatives.processedImages.contrastingImages(:,:,:,1:sampleSize);

% flip horizontally
posSample2 = positives.processedImages.flipHorImages(:,:,:,1:sampleSize);
negSample2 = negatives.processedImages.flipHorImages(:,:,:,1:sampleSize);

% contrast enhanced and flip horizontally
posSample3 = positives.processedImages.contrastingImages(:,:,:,1:sampleSize);
negSample3 = negatives.processedImages.contrastingImages(:,:,:,1:sampleSize);

images = cat(4,posOriIamgeSample,posSample1,posSample2,posSample3,negOriIamgeSample,negSample1,negSample2,negSample3);

features = [];
for index=1:size(images,4)
    feature = histogramOfOrientedGradients(images(:,:,:,index));
    features = [features; feature];
end
features = [[posLabels; posLabels;posLabels;posLabels;negLabels;negLabels;negLabels;negLabels],features];

% only ori images
fprintf("%d original training images\n", sampleSize);
selectFeatures = [features([1:sampleSize,sampleSize*4+1:sampleSize*5],1),...
    features([1:sampleSize,sampleSize*4+1:sampleSize*5],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% ori + contrast enhanced
fprintf("%d original training images + %d contrast enhanced images\n", sampleSize, sampleSize);
selectFeatures = [features([1:sampleSize,sampleSize+1:sampleSize*2,sampleSize*4+1:sampleSize*5,sampleSize*5+1:sampleSize*6],1),...
    features([1:sampleSize,sampleSize+1:sampleSize*2,sampleSize*4+1:sampleSize*5,sampleSize*5+1:sampleSize*6],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% ori + flip hor
fprintf("%d original training images + %d flip horizontally images\n", sampleSize, sampleSize);
selectFeatures = [features([1:sampleSize,sampleSize*2+1:sampleSize*3,sampleSize*4+1:sampleSize*5,sampleSize*6+1:sampleSize*7],1),...
    features([1:sampleSize,sampleSize*2+1:sampleSize*3,sampleSize*4+1:sampleSize*5,sampleSize*6+1:sampleSize*7],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% ori + contrast enhanced and flip hor
fprintf("%d original training images + %d contrast enhanced and flip horizontally images\n", sampleSize, sampleSize);
selectFeatures = [features([1:sampleSize,sampleSize*3+1:sampleSize*4,sampleSize*4+1:sampleSize*5,sampleSize*7+1:sampleSize*8],1),...
    features([1:sampleSize,sampleSize*3+1:sampleSize*4,sampleSize*4+1:sampleSize*5,sampleSize*7+1:sampleSize*8],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% it can be found all combination can reduce the error rate
% select ori + contrast enhanced and flip hor for further analysis
end
