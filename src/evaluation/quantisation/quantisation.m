function quantisation(result, output)
    filePaths = numerisation(result, output);
    test = readDataset("../dataset/test.dataset");

    % LCS Evaluation
    filePath = filePaths(1);
    LCS = readDataset(filePath);
    [positives, negatives] = compareDataset(test, LCS);
    printEvaluation(positives, negatives, "LCS");

    % NMS IoU Evaluation
    filePath = filePaths(2);
    NMS_IoU = readDataset(filePath);
    [positives, negatives] = compareDataset(test, NMS_IoU);
    printEvaluation(positives, negatives, "NMS IoU");

    % NMS IoM Evaluation
    filePath = filePaths(3);
    NMS_IoM = readDataset(filePath);
    [positives, negatives] = compareDataset(test, NMS_IoM);
    printEvaluation(positives, negatives, "NMS IoM");
end

function printEvaluation(positives, negatives, name)
    result = table(positives, negatives, 'VariableNames', {'positive', 'negative'}, 'RowNames', {'pedestrian', 'non-pedestrian'});
    fprintf("Confusion Matrix for %s result\n", name);
    disp(result);
    fprintf("\n");
end
