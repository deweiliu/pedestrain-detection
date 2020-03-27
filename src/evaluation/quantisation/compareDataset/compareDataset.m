function [positives, negatives] = compareDataset(test, prediction)
    nImages = size(test, 1);
    count = 0;

    for imageIndex = 1:nImages
        correct = compareDatasetPerImage(test(imageIndex), prediction(imageIndex));
        count = count + correct;
    end

    pPositive = count;
    pNegative = totalCount(test) - pPositive;
    npPositive = totalCount(prediction) - pPositive;
    npNegative = Inf;

    positives = [pPositive; npPositive];
    negatives = [pNegative; npNegative];

end

function total = totalCount(images)
    total = 0;

    for imageIndex = 1:size(images, 1)
        total = total + images(imageIndex).nPedestrians;
    end

end
