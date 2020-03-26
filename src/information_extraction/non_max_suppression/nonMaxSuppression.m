function NMS = nonMaxSuppression(pedestrians,labelName)
    threshold = 0;
    NMS = [];

    for frameIndex = 1:pedestrians.number
        result.frameIndex = frameIndex;
        [result.image, result.data] = nonMaxSuppressionPerFrame(pedestrians, threshold, frameIndex,labelName);
        result.framePath=pedestrians.paths(frameIndex);
        NMS = [NMS; result];

    end

end
