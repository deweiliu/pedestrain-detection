function [model] = nntrain(positives, negatives)
    % Combine positive + negative features into a single matrix
    model.features = [positives.features;negatives.features];
    % Determine labels for positives + negatives
    model.labels = cat(1, ones(positives.number,1), zeros(negatives.number,1));
    % Determine number of objects
    model.number = length(model.labels);
end

