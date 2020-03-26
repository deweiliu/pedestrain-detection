%% Parameters
% pedestrians(struct) - the pedestrians object
% model(model) - the fitted model(e.g. SVM, KNN etc.)
%% Returns
% updated_pedestrians(struct) - the updated struct of object pedestrians with predicting labels
function [updated_pedestrians] = pedestriansPredictor(pedestrians, model)

    for scale = 1:size(pedestrians.sliding, 2)
        disp(sprintf("Predicting sliding windows with scale %.2f", pedestrians.sliding(scale).scale))
        nFrames = pedestrians.sliding(scale).nFrames;
        nRows = pedestrians.sliding(scale).nRows;
        nColumns = pedestrians.sliding(scale).nColumns;

        for frameindex = 1:nFrames

            for rowindex = 1:nRows

                for colindex = 1:nColumns
                    % TODO 
                    % to get the score/probability
                    % https://uk.mathworks.com/help/stats/classreg.learning.classif.compactclassificationsvm.predict.html
                    features = pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).features_HOG;
                    [label, score ]= predict(model, features);
                    label = cell2logical(label);
                    pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).label = label;
                    pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).score = score;
                end

            end

        end

    end

    % update the pedestrians struct
    updated_pedestrians = pedestrians;
end
