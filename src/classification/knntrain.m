function [model] = knntrain(positives, negatives)
    % Combine positive + negative features into a single matrix
    model.features = [positives.features;negatives.features];
    % Determine labels for positives + negatives
    model.labels = [positives.labels;negatives.labels];
end

