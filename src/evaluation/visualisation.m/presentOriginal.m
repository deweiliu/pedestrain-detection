function presentOriginal(images, frameIndex, nRows, nColumns )
    subplot(nRows, nColumns, 1);
    imshow(images(:, :, :, frameIndex));
    title(sprintf("Original Image Frame = %d", frameIndex));
end
