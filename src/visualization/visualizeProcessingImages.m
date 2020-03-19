function [] = visualizeProcessingImages(imageStruct, imageIndex)
    VISUALIZATION_DIRECTORY = "../dataset/visualization";
    if exist(VISUALIZATION_DIRECTORY,'dir') == 0
        disp(fprintf("path: %s does not exist.\nCreating one.", VISUALIZATION_DIRECTORY));
        mkdir(VISUALIZATION_DIRECTORY); 
    end
    
    tiledlayout(2,2);
    nexttile
    imshow(imageStruct.images(:,:,:,imageIndex)), title("Original")
    nexttile
    imshow(imageStruct.processedImages.flipHorImages(:,:,:,imageIndex)), title("Flipping horizontally")
    nexttile
    imshow(imageStruct.processedImages.contrastingImages(:,:,:,imageIndex)), title("Contrast enhanced")
    nexttile
    imshow(imageStruct.processedImages.contrastingFlipHorImages(:,:,:,imageIndex)), title("Flipping horizontally & Contrast enhanced")
    
    saveas(gcf, fullfile(VISUALIZATION_DIRECTORY, 'processedImage.jpg'));
end
    