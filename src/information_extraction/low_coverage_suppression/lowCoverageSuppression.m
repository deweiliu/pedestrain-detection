function LCS = lowCoverageSuppression(pedestrians, threshold, connectivity, method)

    LCS = [];

    for frameIndex = 1:pedestrians.number
        result.method = method;
        result.slidingCounting = highlightSliding(pedestrians, method, frameIndex);
        result.labels = labelling(result.slidingCounting, threshold, connectivity, frameIndex);
        [result.boundings, result.data] = boundingBox(result.labels, pedestrians, frameIndex);
        result.frameIndex = frameIndex;
        result.framePath = pedestrians.paths(frameIndex);

        LCS = [LCS; result];
    end

end
