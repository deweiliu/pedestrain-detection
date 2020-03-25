function LCS = lowCoverageSuppression(pedestrians, threshold, connectivity,method)

    LCS.method = method;
    LCS.slidingCounting = highlightSliding(pedestrians, method);
    LCS.labels = labelling(result.slidingCounting, threshold, connectivity);
    LCS.boundings = boundingBox(result.labels, pedestrians);


end
