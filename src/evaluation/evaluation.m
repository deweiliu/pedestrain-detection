function evaluation(result)
    numerisation(result);

    test = readDataset("../dataset/test.dataset");

    LCS = readDataset("../output/LCS.dataset");
    NMS = readDataset("../output/NMS.dataset");

    % pedestrian & non-pedestrian
    [p, np] = compareDataset(test, LCS);
    printEvaluation(p, np, "LCS");

    [p, np] = compareDataset(test, NMS);
    printEvaluation(p, np, "NMS");
end

function printEvaluation(p, np, name)
    result = table(p, np, 'VariableNames', {'positive', 'negative'}, 'RowNames', {'pedestrian', 'non-pedestrian'});
    fprintf("Confusion Matrix for %s result\n", name);
    disp(result);
    fprintf("\n");
end
