function [] = visualizeProcessingImages(imageStruct, imageIndex,output)
    VISUALIZATION_DIRECTORY=fullfile(output,"visualization");
    makedir(VISUALIZATION_DIRECTORY);


    tiledlayout(2, 2);
    nexttile
    imshow(imageStruct.images(:, :, :, imageIndex)), title("Original")
    nexttile
    imshow(imageStruct.processedImages.flipHorImages(:, :, :, imageIndex)), title("Flipping horizontally")
    nexttile
    imshow(imageStruct.processedImages.contrastingImages(:, :, :, imageIndex)), title("Contrast enhanced")
    nexttile
    imshow(imageStruct.processedImages.contrastingFlipHorImages(:, :, :, imageIndex)), title("Flipping horizontally & Contrast enhanced")

    saveas(gcf, fullfile(VISUALIZATION_DIRECTORY, 'processedImage.jpg'));
end
