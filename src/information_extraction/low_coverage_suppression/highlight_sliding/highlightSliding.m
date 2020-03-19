%% Given the pedestrians frames(images)
% return a 3-D matrix representing the frames,
% For each pixel (x,y,frameIndex) in the matrix, if there are N sliding windows covering this pixel,
% the value of (x,y,frameIndex) is equal to N
%
% Parameters:
% pedestrians - The pedestrians object
%
% Return:
% slidingCounts (list of structs) - each struct represent one frame
% field - counts(2-D matrix) -  image presenting the count of each pixel
% field - maxCounts(integer) -  the maximum value of the field [counts]
% field - title(string) - the title text of the image
% field - frameIndex(integer) - the index of current frame
% field - image(2-D matrix) - displayable image of current frame
function slidingCounts = highlightSliding(pedestrians, method)
    slidingCounts = [];

    for frameIndex = 1:pedestrians.number
        counts = highlightSlidingPerFrame(pedestrians, frameIndex, method);
        maxCount = max(max(counts));

        highlightedImage.frameIndex = frameIndex;
        highlightedImage.title = sprintf("MAX(number of sliding windows convered, per pixel) = %d", maxCount);
        % reference https://uk.mathworks.com/help/images/ref/stretchlim.html
        highlightedImage.image = imadjust(counts, stretchlim(counts, 0), []);
        highlightedImage.counts = counts;
        highlightedImage.maxCount = maxCount;

        slidingCounts = [slidingCounts; highlightedImage];
    end

end
