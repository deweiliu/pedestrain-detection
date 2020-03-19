%% Given the pixel counts of each frame in pedestrians
% return a struct representing the labels,

%
% Parameters:
% pedestrians - The pedestrians object
%
% Return:
% labelledImages (list of structs) - each struct represent one frame
% field - number(integer) - the number of the pedestrian in current image
% field - title(string) - the title text of the image
% field - frameIndex(integer) - the index of current frame
% field - image(2-D matrix) - displayable image of current frame
% field - labels(2-D matrix) - labels returned by [bwlabel]
function labelledImages = labelling(slidingCounts, threshold, connectivity)
    nFrames = size(slidingCounts);
    labelledImages = [];

    for frameIndex = 1:nFrames
        slidingCount = slidingCounts(frameIndex).counts;
        binaryImage = slidingCount >= threshold;
        labels = bwlabel(binaryImage, connectivity);
        number = max(max(labels));

        labelledImage.frameIndex = frameIndex;
        labelledImage.title = sprintf("Counting threshold = %d", threshold);
        labelledImage.image = label2rgb(labels, "spring", "black");
        labelledImage.number = number;
        labelledImage.labels = labels;

        labelledImages = [labelledImages; labelledImage];
    end

end
