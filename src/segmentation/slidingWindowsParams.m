%% Given the pedestrians object and perform the Sliding Window operation
%% Parameters:
% pedestrians (struct) - the pedestrians object
% scales (array) - each value in the array represents a scale value
% The width of each of the final sliding window is slidingWidth*scale
% The height of each of the final sliding window is slidingHeight*scale
% gapPercentage (double), 0~1 - the gap of two sliding windows (in percentage)
%% Return:
% A list of struct
% field - originFrame: 4-D array representing the original video
% field - slidingWidth: The width of each sliding image
% field - slidingHeight: The height of each sliding image
% field - horizontalGap/verticalGap: is the number of pixels which is the gap between each sliding windows
% field - nRows*nColumns: is the number of sliding images in each frame
% field - nRows*nColumns*nFrames: is the number of sliding images in the video
% field - slidingWindows (3D matrix of objects) - All the sliding windows in the video. Usage: slidingWindows(rowIndex,columnIndex,frameIndex) is an object containing a sliding image
function slidingWindowsList = slidingWindowsParams(pedestrians,slidingWidth,slidingHeight,scales,gapPercentage)
frames=pedestrians.images;
slidingWindowsList=[];
for scaleIndex=1:length(scales)
scale=scales(scaleIndex);
slidingWindowsPerVideo=slidingWindowsVideo(frames,slidingWidth,slidingHeight,scale,gapPercentage);
slidingWindowsList=[slidingWindowsList,slidingWindowsPerVideo];
end

end

