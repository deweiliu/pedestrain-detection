function displayImage(imageStruct, nRows, nColumns, plotIndex)
    subplot(nRows, nColumns, plotIndex);
    imshow(imageStruct.image);
    title(imageStruct.title);
end