function [processedImageStruct] = preprocessing(imageStruct)
    imageNums = size(imageStruct.images, 4);
    
    % processing: Data augementation, generate more training item
    % flip image vertically
    images = uint8.empty;
    for index = 1:imageNums
        processedImage = flipVertically(imageStruct.images(:,:,:,index));
        images(:, :, :, index) = processedImage;
    end
    disp(fprintf("image augementation processing, creating flip vertically images ,%d images in total", imageNums));
    imageStruct.processedImages.flipVerImages = images;

    % processing: contrast stretch on original images
    images = uint8.empty;
    for index = 1:imageNums
        processedImage = contrastStretch(imageStruct.images(:,:,:,index));
        images(:, :, :, index) = processedImage;
    end
    disp(fprintf("contrast stretch processing, %d images in total", imageNums));
    imageStruct.processedImages.contrastingImages = images;

    % processing: contrast stretch on flipped vertically images
    images = uint8.empty;
    for index = 1:imageNums
        processedImage = contrastStretch(imageStruct.processedImages.flipVerImages(:,:,:,index));
        images(:, :, :, index) = processedImage;
    end
    disp(fprintf("contrast stretch on filped images processing, %d images in total", imageNums));
    imageStruct.processedImages.contrastingFlipVerImages = images;
    
    % update the struct
    processedImageStruct = imageStruct;
end
