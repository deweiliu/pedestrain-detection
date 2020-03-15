function [result] = crossValidatedAccuracy(features, numberOfFolds)
    fprintf("Running cross validation for accuracy with %d folds\n", numberOfFolds)
    % first col is the label, second col is the name
    labels = features(:,1);
    % the rest is feature info
    featureData = features(:,3:end);
    indices = crossvalind('Kfold',height(features),numberOfFolds);
    totalYesCorrect = 0;
    totalNoCorrect = 0;
    totalYes = 0;
    totalNo = 0;
    for i = 1:numberOfFolds
        fprintf("Building model for fold k=%d\n", i)
        test = (indices == i);
        train = ~test;
        model = svmTrain(features(train, :));
        fprintf("Testing model for fold k=%d\n", i)
        actual = labels{test, 1};
        predicted = predict(model, featureData(test, :));
        
        totalYesCorrect = totalYesCorrect + sum(actual == predicted & actual == 1);
        totalNoCorrect = totalNoCorrect + sum(actual == predicted & actual == 0);
        totalYes = totalYes + sum(actual == 1);
        totalNo = totalNo + sum(actual == 0);
        
    end
    totalYesIncorrect = totalYes - totalYesCorrect;
    totalNoIncorrect = totalNo - totalNoCorrect;
    result = array2table([
        [totalYesCorrect / totalYes, totalNoIncorrect / totalNo];
        [totalYesIncorrect / totalYes, totalNoCorrect / totalNo];
    ],"VariableNames", ["Pedestrian", "No Pedestrian"], "RowNames", ["Pedestrian", "No Pedestrian"]);
end

