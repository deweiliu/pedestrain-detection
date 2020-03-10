function presentOriginal(images, frameIndex, nRows, nColumns)
    plotIndex = nColumns;
    subplot(nRows, nColumns, plotIndex);
    imshow(images(:, :, :, frameIndex));
    title(sprintf("Original Image Frame = %d", frameIndex));
end
