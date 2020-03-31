%% Before running this script
% You have to ensure section 1 and 2 in "main.m" have been run

%% Visualize original training images and processed training images

IMAGE_INDEX = 1;
IMAGE_TYPE = positives;
% If IMAGE_TYPE is positives, IMAGE_INDEX must not exceed 2003.
% If IMAGE_TYPE is negatives, IMAGE_INDEX must not exceed 997.
VISUALIZATION_DIRECTORY=fullfile(output,"processedImagesVisualization");
makedir(VISUALIZATION_DIRECTORY);

tiledlayout(2, 2);
nexttile
imshow(IMAGE_TYPE.images(:, :, :, IMAGE_INDEX)), title("Original")
nexttile
imshow(IMAGE_TYPE.processedImages.flipHorImages(:, :, :, IMAGE_INDEX)), title("Flipping horizontally")
nexttile
imshow(IMAGE_TYPE.processedImages.contrastingImages(:, :, :, IMAGE_INDEX)), title("Contrast enhanced")
nexttile
imshow(IMAGE_TYPE.processedImages.contrastingFlipHorImages(:, :, :, IMAGE_INDEX)), title("Flipping horizontally & Contrast enhanced")
saveas(gcf, fullfile(VISUALIZATION_DIRECTORY, 'processedImage.jpg'));
