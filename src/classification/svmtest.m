%% Reference
% https://uk.mathworks.com/help/stats/fitcsvm.html#d118e343944
function [] = svm_test(model)
    cv_svm_model = crossval(model);
    loss_rate = kfoldLoss(cv_svm_model);
    disp(loss_rate)
end

