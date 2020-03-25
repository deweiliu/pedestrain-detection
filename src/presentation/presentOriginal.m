function presentOriginal(images, frameIndex, nRows, nColumns, plotIndex)
    subplot(nRows, nColumns, plotIndex);
    imshow(images(:, :, :, frameIndex));
    title(sprintf("Original Image Frame = %d", frameIndex));
end
