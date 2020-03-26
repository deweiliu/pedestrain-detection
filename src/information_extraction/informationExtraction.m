function results = informationExtraction(pedestrians, threshold, connectivity)

    labelName = "label";
    results.LCS = lowCoverageSuppression(pedestrians, threshold, connectivity, labelName);

    results.NMS = nonMaxSuppression(pedestrians,labelName);
end
