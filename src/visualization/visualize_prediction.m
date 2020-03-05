%% Parameters
% pedestrians(struct) - the pedestrians object
% scale_index(int) - the index of SLIDING_SCALES
% frame_index(int) - the index of frames
function [] = visualize_prediction(pedestrians, scale_index, frame_index)
pedestrians.sliding(scale_index).windows(:,:,frame_index)
nRows = pedestrians.sliding(scale_index).nRows;
nCols = pedestrians.sliding(scale_index).nColumns;
num = 0;
for rowindex = 1:nRows
    for colindex = 1:nCols
        if pedestrians.sliding(scale_index).windows(rowindex, colindex, frame_index).label == 1
            % display all images which are predicted as human image
            imshow(pedestrians.sliding(scale_index).windows(rowindex, colindex, frame_index).image)
            num = num + 1;
            pause(1)
        end
    end
end
disp(fprintf("There are %d sub-images predicted as 1 with scale_index %d, frame_index %d",num, scale_index, frame_index))
end

