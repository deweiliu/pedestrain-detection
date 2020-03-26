function [NMSImage, data] = nonMaxSuppressionPerFrame(pedestrians, frameIndex, labelName)
    newPedestrian = true;
    image = pedestrians.images(:, :, :, frameIndex);
    sliding = pedestrians.sliding;
    data = [];

    while newPedestrian
        % Keep searching for new pedestrian until none is found

        target = findPedestrian(sliding, frameIndex, labelName);

        if target.(labelName) == false
            % No new pedestrian was found
            % End the loop
            newPedestrian = false;
        else
            sliding = removePedestrian(sliding, frameIndex, target, labelName);
            box.x = target.x;
            box.y = target.y;
            box.width = target.width;
            box.height = target.height;

            data = [data; box];

            image = mergeImageBounding(image, box, "green");
        end

    end

    NMSImage.image = image;
    NMSImage.title = sprintf("NMS: %d Pedestrians", size(data, 1));
end

function target = findPedestrian(sliding, frameIndex, labelName)
    nScale = size(sliding, 2);
    target.PostProbs = 0;
    target.(labelName) = false;

    for scaleIndex = 1:nScale
        nRows = sliding(scaleIndex).nRows;
        nColumns = sliding(scaleIndex).nColumns;

        for rowIndex = 1:nRows

            for columnIndex = 1:nColumns
                window = sliding(scaleIndex).windows(rowIndex, columnIndex, frameIndex);

                if window.(labelName) == true & window.PostProbs > target.PostProbs
                    target = window;
                end

            end

        end

    end

end

function [sliding] = removePedestrian(sliding, frameIndex, target, labelName)
    nScale = size(sliding, 2);

    for scaleIndex = 1:nScale
        nRows = sliding(scaleIndex).nRows;
        nColumns = sliding(scaleIndex).nColumns;

        for rowIndex = 1:nRows

            for columnIndex = 1:nColumns
                window = sliding(scaleIndex).windows(rowIndex, columnIndex, frameIndex);

                if window.(labelName) == true

                    if isSamePedestrian(target, window)
                        sliding(scaleIndex).windows(rowIndex, columnIndex, frameIndex).(labelName) = false;
                    end

                end

            end

        end

    end

end

%% If two sliding windows overlap eachother for more than 50%
% return true; else return false
function isSame = isSamePedestrian(window1, window2)
    interction = rectint(window1.position, window2.position);
    area1 = window1.width * window1.height;
    area2 = window2.width * window2.height;

    if (interction > area1 / 2) | (interction > area2 / 2)
        isSame = true;
    else
        isSame = false;
    end

end
