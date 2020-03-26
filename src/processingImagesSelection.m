%% Set up Environment
setupEnvir;

%% Training images Pre-processing
positives = preprocessing(positives);
negatives = preprocessing(negatives);

%% Processed images analysis
% the number of images selected from each type of candidate training images.
SAMPLE_SIZE = 350;

posLabels = positives.labels(1:SAMPLE_SIZE,:);
negLabels = negatives.labels(1:SAMPLE_SIZE,:);
posOriIamgeSample = positives.images(:,:,:,1:SAMPLE_SIZE);
negOriIamgeSample = negatives.images(:,:,:,1:SAMPLE_SIZE);

% contrast enhanced
posSample1 = positives.processedImages.contrastingImages(:,:,:,1:SAMPLE_SIZE);
negSample1 = negatives.processedImages.contrastingImages(:,:,:,1:SAMPLE_SIZE);

% flip horizontally
posSample2 = positives.processedImages.flipHorImages(:,:,:,1:SAMPLE_SIZE);
negSample2 = negatives.processedImages.flipHorImages(:,:,:,1:SAMPLE_SIZE);

% contrast enhanced and flip horizontally
posSample3 = positives.processedImages.contrastingImages(:,:,:,1:SAMPLE_SIZE);
negSample3 = negatives.processedImages.contrastingImages(:,:,:,1:SAMPLE_SIZE);

images = cat(4,posOriIamgeSample,posSample1,posSample2,posSample3,negOriIamgeSample,negSample1,negSample2,negSample3);

features = [];
for index=1:size(images,4)
    feature = histogramOfOrientedGradients(images(:,:,:,index));
    features = [features; feature];
end
features = [[posLabels; posLabels;posLabels;posLabels;negLabels;negLabels;negLabels;negLabels],features];

% only ori images
fprintf("%d original training images\n", SAMPLE_SIZE);
selectFeatures = [features([1:SAMPLE_SIZE,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5],1),...
    features([1:SAMPLE_SIZE,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% ori + contrast enhanced
fprintf("%d original training images + %d contrast enhanced images\n", SAMPLE_SIZE, SAMPLE_SIZE);
selectFeatures = [features([1:SAMPLE_SIZE,SAMPLE_SIZE+1:SAMPLE_SIZE*2,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5,SAMPLE_SIZE*5+1:SAMPLE_SIZE*6],1),...
    features([1:SAMPLE_SIZE,SAMPLE_SIZE+1:SAMPLE_SIZE*2,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5,SAMPLE_SIZE*5+1:SAMPLE_SIZE*6],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% ori + flip hor
fprintf("%d original training images + %d flip horizontally images\n", SAMPLE_SIZE, SAMPLE_SIZE);
selectFeatures = [features([1:SAMPLE_SIZE,SAMPLE_SIZE*2+1:SAMPLE_SIZE*3,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5,SAMPLE_SIZE*6+1:SAMPLE_SIZE*7],1),...
    features([1:SAMPLE_SIZE,SAMPLE_SIZE*2+1:SAMPLE_SIZE*3,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5,SAMPLE_SIZE*6+1:SAMPLE_SIZE*7],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% ori + contrast enhanced and flip hor
fprintf("%d original training images + %d contrast enhanced and flip horizontally images\n", SAMPLE_SIZE, SAMPLE_SIZE);
selectFeatures = [features([1:SAMPLE_SIZE,SAMPLE_SIZE*3+1:SAMPLE_SIZE*4,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5,SAMPLE_SIZE*7+1:SAMPLE_SIZE*8],1),...
    features([1:SAMPLE_SIZE,SAMPLE_SIZE*3+1:SAMPLE_SIZE*4,SAMPLE_SIZE*4+1:SAMPLE_SIZE*5,SAMPLE_SIZE*7+1:SAMPLE_SIZE*8],2:end)];
rng(3064)
selectFeatures = selectFeatures(randperm(size(selectFeatures,1)),:);
model = fitcsvm(selectFeatures(:,2:end), selectFeatures(:,1), 'KernelFunction', 'linear');
svmTest(model)

% it can be found all combination can reduce the error rate
% combination ori + contrast enhanced and flip hor is the best one
