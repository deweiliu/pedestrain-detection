function results = proposalFilter(pedestrians, labelName)
    %% Original Images
    results.origin = pedestrians.images;

    %% LCS
    THRESHOLD = 5; % Greater or equal to 1, integer
    LABELLING_CONNECTIVITY = 4; % 8 or 4  # See https://uk.mathworks.com/help/images/ref/bwlabel.html
    results.LCS = lowCoverageSuppression(pedestrians, THRESHOLD, LABELLING_CONNECTIVITY, labelName);

    %% NMS Intersection Over Union
    IoU = true;
    results.NMS_IoU = nonMaxSuppression(pedestrians, labelName, IoU);

    %% NMS Intersection Over Minimum
    IoU = false;
    results.NMS_IoM = nonMaxSuppression(pedestrians, labelName, IoU);

end
