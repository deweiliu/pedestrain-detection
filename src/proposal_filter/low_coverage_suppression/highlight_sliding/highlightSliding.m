%% Given the pedestrians frame
% For each pixel (x,y) in the matrix, if there are N sliding windows covering this pixel,
% the value of (x,y) is equal to N
%
% Parameters:
% pedestrians - The pedestrians object
%
% Return:
% slidingCounts (struct) - The struct contains the following fields
% field - counts(2-D matrix) -  image presenting the count of each pixel
% field - maxCounts(integer) -  the maximum value of the field [counts]
% field - title(string) - the title text of the image
% field - frameIndex(integer) - the index of current frame
% field - image(2-D matrix) - displayable image of current frame
function highlightedImage = highlightSliding(pedestrians, method, frameIndex)

    [counts, nWindows] = highlightSlidingPerFrame(pedestrians, frameIndex, method);

    highlightedImage.title = sprintf("%d Sliding Windows Detected", nWindows);
    % reference https://uk.mathworks.com/help/images/ref/stretchlim.html
    highlightedImage.image = imadjust(counts, stretchlim(counts, 0), []);
    highlightedImage.counts = counts;

end
