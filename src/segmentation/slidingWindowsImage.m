%% Given an image to perform sliding windows
% returns a 2-D matrix of objects
% Each object contains a slidinged image
function slidingWindows=slidingWindowsImage(image,slidingWidth,slidingHeight,horizontalGap,verticalGap)
imgHeight=size(image,1);
slidingWindows=[];
for y=1:verticalGap:(imgHeight-slidingHeight+1)
slidingWindow=slidingWindowsRow(image,y,slidingWidth,slidingHeight,horizontalGap);
slidingWindows=[slidingWindows;slidingWindow];
end


end