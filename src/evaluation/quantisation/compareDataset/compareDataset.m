function [p, np] = compareDataset(test, prediction)
    nImages = size(test, 1);
    count = 0;

    for imageIndex = 1:nImages
        correct = compareDatasetPerImage(test(imageIndex), prediction(imageIndex));
        count = count + correct;
    end

    pPositive = count;
    pNegative = totalCount(test) - pPositive;
    p = [pPositive; pNegative];

    npPositive = totalCount(prediction) - pPositive;
    np = [npPositive; Inf];

end

function total = totalCount(images)
    total = 0;

    for imageIndex = 1:size(images, 1)
        total = total + images(imageIndex).nPedestrians;
    end

end
