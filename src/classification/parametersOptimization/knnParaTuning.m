function [] = knnParaTuning(features)
    GRAPHS_DIRECTORY = "../graphs";
    % First col is the label, second col is the name
    labels = features(:,1);
    % The rest is feature info
    featureData = features(:,3:end);
    errorRates = [];
    kvalue_list = (0:50-1)*2+1;
    for index = 1:length(kvalue_list)
        fprintf('Fitting KNN model with %d as k value\n', kvalue_list(index));
        model = fitcknn(featureData, labels, 'NumNeighbors', kvalue_list(index));
        crossValModel = crossval(model);
        lossRate = kfoldLoss(crossValModel);
        fprintf("The error rate is: %.6f\n", lossRate);
        errorRates = [errorRates,lossRate];
    end
    % save the plot
    knnFig = figure;
    plot(kvalue_list,errorRates)
    xlabel('k value')
    ylabel('Error rate')
    title('KNN model k value detection')
    saveas(knnFig, fullfile(GRAPHS_DIRECTORY, 'knnParaTuning.jpg'));
end

