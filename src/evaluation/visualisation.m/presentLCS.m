function presentLCS(LCS, nRows, nColumns)
    % Display counting sliding window image
    plotIndex = nColumns + 1;
    displayImage(LCS.slidingCounting, nRows, nColumns, plotIndex);

    % Display counting labelled image
    plotIndex = nColumns + 2;
    displayImage(LCS.labels, nRows, nColumns, plotIndex);

    % Display counting bounding box image
    plotIndex = nColumns + 3;
    displayImage(LCS.boundings, nRows, nColumns, plotIndex);
end
