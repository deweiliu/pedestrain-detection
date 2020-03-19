function results = lowCoverageSuppression(pedestrians, threshold, connectivity,classifiers)

    results = [];
    % For each method
    for methodIndex = 1:size(classifiers, 1)

        % Calculate the images
        method = classifiers(methodIndex);

        result.method = method;
        result.slidingCounting = highlightSliding(pedestrians, method);
        result.labels = labelling(result.slidingCounting, threshold, connectivity);
        result.boundings = boundingBox(result.labels, pedestrians);

        results = [results; result];
    end

end
