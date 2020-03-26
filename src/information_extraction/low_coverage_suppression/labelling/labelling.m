%% Given the pixel counts of each frame in pedestrians
% return a struct representing the labels,

%
% Parameters:
% pedestrians - The pedestrians object
%
% Return:
% labelledImages (struct) - The struct contains the following fields
% field - number(integer) - the number of the pedestrian in current image
% field - title(string) - the title text of the image
% field - frameIndex(integer) - the index of current frame
% field - image(2-D matrix) - displayable image of current frame
% field - labels(2-D matrix) - labels returned by [bwlabel]
function labelledImage = labelling(slidingCounts, threshold, connectivity, frameIndex)

    slidingCount = slidingCounts.counts;
    binaryImage = slidingCount >= threshold;
    labels = bwlabel(binaryImage, connectivity);
    number = max(max(labels));

    labelledImage.frameIndex = frameIndex;
    labelledImage.title = sprintf("LCS: Counting threshold = %d", threshold);
    labelledImage.image = label2rgb(labels, "spring", "black");
    labelledImage.number = number;
    labelledImage.labels = labels;


end
