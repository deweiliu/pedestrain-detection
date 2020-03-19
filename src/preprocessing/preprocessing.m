function [processedImageStruct] = preprocessing(imageStruct)
    imageNums = size(imageStruct.images, 4);
    % processing: Data augementation, generate more training item
    % flip image horizontally
    images = uint8.empty;
    for index = 1:imageNums
        processedImage = flipHorizontally(imageStruct.images(:,:,:,index));
        images(:, :, :, index) = processedImage;
    end
    disp(fprintf("Image augementation running, creating fliping horizontally images"));
    imageStruct.processedImages.flipHorImages = images;

    % processing: contrast stretch on original images
    images = uint8.empty;
    for index = 1:imageNums
        processedImage = contrastStretch(imageStruct.images(:,:,:,index));
        images(:, :, :, index) = processedImage;
    end
    disp(fprintf("Image augementation running, creating contrast enhanced images"));
    imageStruct.processedImages.contrastingImages = images;

    % processing: contrast stretch on flipped vertically images
    images = uint8.empty;
    for index = 1:imageNums
        processedImage = contrastStretch(imageStruct.processedImages.flipHorImages(:,:,:,index));
        images(:, :, :, index) = processedImage;
    end
    disp(fprintf("Image augementation running, creating contrast enhanced for fliping horizontally images"));
    imageStruct.processedImages.contrastingFlipHorImages = images;
    
    % update the struct
    processedImageStruct = imageStruct;
end
