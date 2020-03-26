%% Parameters
% pedestrians(struct) - the pedestrians object
% model(model) - the fitted model(SVM)
%% Returns
% updated_pedestrians(struct) - the updated struct of object pedestrians with predicting labels
function [updated_pedestrians] = pedestriansPredictor(pedestrians, model)

    for scale = 1:size(pedestrians.sliding, 2)
        fprintf("Predicting sliding windows with scale %.2f", pedestrians.sliding(scale).scale)
        nFrames = pedestrians.sliding(scale).nFrames;
        nRows = pedestrians.sliding(scale).nRows;
        nColumns = pedestrians.sliding(scale).nColumns;
        for frameindex = 1:nFrames
            for rowindex = 1:nRows
                for colindex = 1:nColumns
                    % make prediction for svm
                    label = predict(model, pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).features_HOG);
                    label = cell2logical(label);
                    pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).label_HOG_SVM = label;
                    % TODO 
                    % to get the score/probability
                    % https://uk.mathworks.com/help/stats/classreg.learning.classif.compactclassificationsvm.predict.html
                    pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).label = label;
%                     pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).score = score;
                end
            end
        end
    end
    % update the pedestrians struct
    updated_pedestrians = pedestrians;
end

function label = cell2logical(origianlLabel)
    label = origianlLabel;
    if iscell(label)
        label = label{1, 1};
    end
    label = logical(label);
end

