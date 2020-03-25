function NMS = nonMaxSuppression(pedestrians)
    threshold = 0;
    NMS = [];

    for frameIndex = 1:pedestrians.number
        result.frameIndex = frameIndex;
        [result.image, result.data] = nonMaxSuppressionPerFrame(pedestrians, threshold, frameIndex);
        NMS = [NMS; result];

    end

end
