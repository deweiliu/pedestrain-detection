function [] = knnTest(model)
    crossValModel = crossval(model);
    lossRate = kfoldLoss(crossValModel);
    disp(fprintf("Using cross validation to test the model. The loss rate is: %d", lossRate))
end
