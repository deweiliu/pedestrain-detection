%% Before running this script
% You have to ensure section 1 to 7 in "main.m" have been run

%%
directory = fullfile(output, "slidingImagesPredictionVisualization");
makedir(directory);
fig=figure(1);

for scale = 1:size(pedestrians.sliding, 2)
    pedestrians.sliding(scale).windows(:, :, frame_index);
    nRows = pedestrians.sliding(scale).nRows;
    nCols = pedestrians.sliding(scale).nColumns;
    num = 0;
    for rowindex = 1:nRows
        for colindex = 1:nCols
            if pedestrians.sliding(scale).windows(rowindex, colindex, frame_index).label_HOG_SVM == 1
                disp(pedestrians.sliding(scale).windows(rowindex, colindex, frame_index).PostProbs)
                num = num + 1;
                % display all images which are predicted as human image
                image = pedestrians.sliding(scale).windows(rowindex, colindex, frame_index).image;
                imshow(image);
                title(strcat('scale size:', num2str(pedestrians.sliding(scale).scale)), 'FontSize', 10);
                imageName = strcat('scale_', num2str(pedestrians.sliding(scale).scale), '_frame_', num2str(frame_index), ...
                    '_img_', num2str(num), '.jpg');
                saveas(fig, fullfile(directory, imageName));
                pause(0.5);
            end
        end
    end
    disp(sprintf("Using scale %.2f, there are %d sliding windows predicted as pedestrians in frame No. %d", pedestrians.sliding(scale).scale, num, frame_index)); %#ok<DSPS>
end


