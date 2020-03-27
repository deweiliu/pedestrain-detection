function filePaths = numerisation(results, output)

    methods = ["LCS"; "NMS_IoU"; "NMS_IoM"];
        filePaths = [];

        for index = 1:size(methods)
            filePath = writeResult(results.(methods(index)), methods(index), output);
            filePaths = [filePaths; filePath];
            fprintf("Result data of %s has been written at %s\n", methods(index), filePath);

        end

    end
