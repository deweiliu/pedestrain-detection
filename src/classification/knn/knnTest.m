function [] = knnTest(model)
    crossValModel = crossval(model);
    lossRate = kfoldLoss(crossValModel);
    fprintf("Using cross validation to test the model. The error rate is: %.6f\n", lossRate);
end
