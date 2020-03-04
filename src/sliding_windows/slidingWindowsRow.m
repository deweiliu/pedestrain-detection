%% Given an image and a specific row (y) to perform sliding windows
% returns a 1-D matrix of objects
% Each object contains a slidinged image
function rowWindows = slidingWindowsRow(image, y, slidingWidth, slidingHeight, horizontalGap)
    imgWidth = size(image, 2);

    rowWindows = [];

    for x = 1:horizontalGap:(imgWidth - slidingWidth + 1)
        position = [x, y, slidingWidth, slidingHeight];
        slidingedImage = cropimage(image, position);
        rowWindows = [rowWindows, slidingedImage];
    end

end
