function [result] = knntest(testing, model, K)
    % for every row in the feature table
    for i=1:height(testing.features)
        % get test value features
        featureRow = testing.features(i, :);
        height(model.features)
        % calculate euclidean distance for between test and training data
        for j=1:height(model.features)
            comparisonRow = model.features(j, :);
            eucDistance = euclideandistance(featureRow, comparisonRow);
            distanceLabels(j, 1) = eucDistance;
            distanceLabels(j, 2) = model.labels(j);
        end
        % sort by distance
        [~, idx] = sort(distanceLabels(:, 1));
        sorted = distanceLabels(idx,:);
        % select closest k values
        closest = sorted(1:K,2);
        % set prediction to most frequent label
        result(i, 1) = mode(closest);
    end
end