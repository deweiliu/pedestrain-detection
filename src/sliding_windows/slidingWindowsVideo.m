%% Given a video to perform sliding windows
% Parameters
% frames: 3D matrix of pixel values
% horizontalGap/verticalGap: is the number of pixels which is the gap between each sliding windows
%
% RETURN: a struct with the following fields
% A list of struct
% field - width: The width of each sliding image
% field - height: The height of each sliding image
% field - horizontalGap/verticalGap: is the number of pixels which is the gap between each sliding windows
% field - nRows*nColumns: is the number of sliding images in each frame
% field - nRows*nColumns*nFrames: is the number of sliding images in the video
% field - windows (3D matrix of objects) - All the sliding windows in the video. Usage: slidingWindows(rowIndex,columnIndex,frameIndex) is an object containing a sliding image
%
function slidingWindowsResult = slidingWindowsVideo(frames, slidingWidth, slidingHeight, scale, gapPercentage)
    slidingWidth = uint16(double(slidingWidth) * double(scale));
    slidingHeight = uint16(double(slidingHeight) * double(scale));
    horizontalGap = uint16(double(slidingWidth) * double(gapPercentage));
    verticalGap = uint16(double(slidingHeight) * double(gapPercentage));

    nFrames = size(frames, 4);

    % Get the sliding windows for each frame in the video

    for index = 1:nFrames
        image = frames(:, :, :, index);
        slidingFrame = slidingWindowsImage(image, slidingWidth, slidingHeight, horizontalGap, verticalGap);
        slidingFrames(:, :, index) = slidingFrame;
    end

    % Save the result    
    output.windows = slidingFrames;
    output.width = slidingWidth;
    output.height = slidingHeight;
    output.horizontalGap = horizontalGap;
    output.verticalGap = verticalGap;
    output.nRows = size(slidingFrames, 1);
    output.nColumns = size(slidingFrames, 2);
    output.nFrames = size(slidingFrames, 3);
    output.scale = scale;
    output.gapPercentage = gapPercentage;

    slidingWindowsResult = output;
end
