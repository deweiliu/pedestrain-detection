% reference https://uk.mathworks.com/help/stats/treebagger.html
% Given training data, returns the model fitted by random forest
function model = randomForestTrain(features,labels)
    dependentValues = table2array(features(:, 3:end));
    labels = table2array(features(:, 1));
    model = TreeBagger(10, dependentValues, labels, 'OOBPrediction', 'On', 'Method', 'classification');

end
