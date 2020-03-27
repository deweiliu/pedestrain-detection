function quantisation(result)
    numerisation(result);

    test = readDataset("../dataset/test.dataset");

    LCS = readDataset("../output/LCS.dataset");
    NMS_IoU = readDataset("../output/NMS_IoU.dataset");
    NMS_IoM = readDataset("../output/NMS_IoM.dataset");

    % pedestrian & non-pedestrian
    [p, np] = compareDataset(test, LCS);
    printEvaluation(p, np, "LCS");

    [p, np] = compareDataset(test, NMS_IoU);
    printEvaluation(p, np, "NMS IoU");
    [p, np] = compareDataset(test, NMS_IoM);
    printEvaluation(p, np, "NMS IoM");
end

function printEvaluation(p, np, name)
    result = table(p, np, 'VariableNames', {'positive', 'negative'}, 'RowNames', {'pedestrian', 'non-pedestrian'});
    fprintf("Confusion Matrix for %s result\n", name);
    disp(result);
    fprintf("\n");
end
