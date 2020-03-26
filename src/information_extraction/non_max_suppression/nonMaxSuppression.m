function NMS = nonMaxSuppression(pedestrians, labelName)
    NMS = [];

    for frameIndex = 1:pedestrians.number
        result.frameIndex = frameIndex;
        [result.image, result.data] = nonMaxSuppressionPerFrame(pedestrians, frameIndex, labelName);
        result.framePath = pedestrians.paths(frameIndex);
        NMS = [NMS; result];

    end

end
