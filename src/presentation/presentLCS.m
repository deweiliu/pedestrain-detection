function presentLCS(result, nRows, nColumns, plotIndex)
    % Display method name
    subplot(nRows, nColumns, plotIndex);
    % reference https://uk.mathworks.com/matlabcentral/answers/96629-why-does-setting-the-visible-property-for-axes-to-off-also-set-the-visible-property-for-title
    set(gca, 'visible', 'off')
    text(0.5, 0.5, strrep(result.method, '_', ' '));

    % Display counting sliding window image
    plotIndex = plotIndex + 1;
    displayImage(result.slidingCounting, nRows, nColumns, plotIndex);

    % Display counting labelled image
    plotIndex = plotIndex + 1;
    displayImage(result.labels, nRows, nColumns, plotIndex);

    % Display counting bounding box image
    plotIndex = plotIndex + 1;
    displayImage(result.boundings, nRows, nColumns, plotIndex);
end

function displayImage(imageStruct, nRows, nColumns, plotIndex)
    subplot(nRows, nColumns, plotIndex);
    imshow(imageStruct.image);
    title(imageStruct.title);
end
