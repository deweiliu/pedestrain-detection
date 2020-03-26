% reference https://uk.mathworks.com/help/stats/treebagger.html
% Given training data, returns the model fitted by random forest
function model = randomForestTrain(features, labels,numTrees)
    dependentValues = tableToArray(features);
    labels = tableToArray(labels);
    model = TreeBagger(numTrees, dependentValues, labels, 'OOBPrediction', 'On', 'Method', 'classification');

end

