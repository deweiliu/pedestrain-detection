%% Reference
% https://uk.mathworks.com/help/stats/fitcsvm.html#d118e343944
function [] = svmtest(model)
    cv_svm_model = crossval(model);
    loss_rate = kfoldLoss(cv_svm_model);
    disp(fprintf("Using cross validation to test the model. The loss rate is: %d", loss_rate))
end

