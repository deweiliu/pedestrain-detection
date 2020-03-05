%% Parameters
% pedestrians(struct) - the pedestrians object
%% Returns
% updated_pedestrians(struct) - the updated struct of object pedestrians with generating features
function [updated_pedestrians] = featureextractor_pedestrians(pedestrians)
% looping the scale
for scale = 1: size(pedestrians.sliding, 2)
    nFrames = pedestrians.sliding(scale).nFrames;
    nRows = pedestrians.sliding(scale).nRows;
    nColumns = pedestrians.sliding(scale).nColumns;
    for frameindex = 1: nFrames
        for rowindex = 1:nRows
            for colindex = 1:nColumns
                disp(fprintf("Features generation of image with scale %d frame %d row %d col %d starts.", ...
                    scale, frameindex, rowindex, colindex))
                pedestrians_each = pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).image;
                % resize the image as 160 * 96
                resize_sub_testimage = imresize(pedestrians_each, [160, 96]);
                % generating features
                feature = testfeaturegenerator_HOG(resize_sub_testimage);
                pedestrians.sliding(scale).windows(rowindex, colindex, frameindex).features_HOG = feature;
            end
        end
    end
end
% update the pedestrians struct
updated_pedestrians = pedestrians;
end

