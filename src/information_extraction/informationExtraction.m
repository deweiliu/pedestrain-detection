function results = informationExtraction(pedestrians, threshold, connectivity)

    method = "label_HOG_SVM";
    results.LCS = lowCoverageSuppression(pedestrians, threshold, connectivity, method);

    results.NMS = nonMaxSuppression(pedestrians);
end
