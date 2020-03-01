%% Given coloured images, convert them into gray images
function grayImages = colour2gray(images, number)
    grayImages = uint8.empty;

    for index = 1:number
        colouredImage = images(:, :, :, index);
        grayImage = rgb2gray(colouredImage);
        grayImages(:, :, index) = grayImage;
    end

end
