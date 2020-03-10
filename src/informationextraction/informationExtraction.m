function result = informationExtraction(pedestrians, threshold)

    result.slidingCounting = highlightSliding(pedestrians);
    result.labels = labelling(result.slidingCounting, threshold);
result.boundings=boundingBox(result.labels,pedestrians);
end
