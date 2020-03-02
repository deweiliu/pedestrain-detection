function [result] = knntest(testing, model, K)
    % for every value to be predicted
    for i=1:length(testing.features)
        % get test value features
        testSample = testing.features(i, :);
        % calculate euclidean distance for between test and training data
        for j=1:length(model.features)
            comparison = model.features(j, :);
            eucDistance = euclideandistance(testSample, comparison);
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