%% Parameters
% pedestrians(struct) - the pedestrians object
% model(model) - the fitted model(by SVM,KNN etc.)
%% Returns
% updated_pedestrians(struct) - the updated struct of object pedestrians with predicting labels
function [updated_pedestrians] = fitsvmmodel_pedestrians(pedestrians, model)
for scale = 1:size(pedestrians.sliding,2)
    nFrames = pedestrians.sliding(scale).nFrames;
    nRows = pedestrians.sliding(scale).nRows;
    nColumns = pedestrians.sliding(scale).nColumns;
    for frameindex = 1:nFrames
        for rowindex = 1:nRows
            for colindex = 1:nColumns
                disp(fprintf("Features prediction of image with scale %d frame %d row %d col %d starts.", ...
                    scale, frameindex, rowindex, colindex))
                % make prediction
                predicted_label = ...
                    predict(model, pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).features_HOG);
                pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).label_HOG = predicted_label;
            end
        end
    end
end
% update the pedestrians struct
updated_pedestrians = pedestrians;
end

