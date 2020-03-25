function [bounding, data] = boundingBox(labelledImages, pedestrians, frameIndex)

    originImage = pedestrians.images(:, :, :, frameIndex);
    [bounding, data] = boundingBoxPerFrame(labelledImages, originImage);

end
