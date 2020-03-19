function [] = knnTest(model)
    crossValModel = crossval(model);
    lossRate = kfoldLoss(crossValModel);
    disp(fprintf("Using cross validation to test the model. The error rate is: %.6f", loss_rate))
end
