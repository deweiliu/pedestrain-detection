function results = informationExtraction(pedestrians, threshold, connectivity)

    classifiers = ["label_HOG_SVM"];
    results.LCS = lowCoverageSuppression(pedestrians, threshold, connectivity, classifiers);

    
    results.NMS = nonMaxSuppression(pedestrians);
end
