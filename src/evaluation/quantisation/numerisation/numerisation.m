function numerisation(results)
    methods = ["LCS"; "NMS_IoU";"NMS_IoM"];

    for index = 1:size(methods)
        filePath = writeResult(results.(methods(index)), methods(index));
        fprintf("Result data of %s has been written at %s\n", methods(index), filePath);
    end

end
