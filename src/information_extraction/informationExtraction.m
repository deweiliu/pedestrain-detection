function results = informationExtraction(pedestrians, labelName)
    %% LCS
    THRESHOLD = 2; % Greater or equal to 1, integer
    LABELLING_CONNECTIVITY = 4; % 8 or 4  # See https://uk.mathworks.com/help/images/ref/bwlabel.html
    results.LCS = lowCoverageSuppression(pedestrians, THRESHOLD, LABELLING_CONNECTIVITY, labelName);

    %% NMS
    results.NMS = nonMaxSuppression(pedestrians, labelName);
end
