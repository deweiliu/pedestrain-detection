%% Given the sliding windows and a specific frame number
% return a matrix representing the frame,
% For each pixel (x,y) in the matrix, if there are N sliding windows covering this pixel,
% the value of (x,y) is equal to N
%
% Parameters
% pedestrians - The pedestrians object
% frameIndex - The frame number
%
% Return:
% highlightedImage (2-D matrix)
function highlightedImage = highlightSlidingPerFrame(pedestrians, frameIndex, method)
    rows = pedestrians.nRows;
    columns = pedestrians.nColumns;
    highlightedImage = uint8(zeros(rows, columns));
    identifiedWindows = findIdentifiedWindowsPerFrame(pedestrians.sliding, frameIndex, method);
    nWindows = size(identifiedWindows, 2);

    for windowIndex = 1:nWindows
        highlightedWindow = highlightSlidingPerWindow(rows, columns, identifiedWindows(windowIndex));
        highlightedImage = highlightedImage + highlightedWindow;
    end

    highlightedImage = uint8(highlightedImage);
end

function identifiedWindows = findIdentifiedWindowsPerFrame(allSlidings, frameIndex, method)
    identifiedWindows = [];
    nScales = size(allSlidings, 2);

    % For each scale
    for scaleIndex = 1:nScales
        sliding = allSlidings(1, scaleIndex);

        % for each row and column
        for row = 1:sliding.nRows

            for column = 1:sliding.nColumns

                window = sliding.windows(row, column, frameIndex);

                if verifyResult(window, method)
                    identifiedWindows = [identifiedWindows, window];
                end

            end

        end

    end

end

function isHuman = verifyResult(window, labelName)
    result = window.(labelName);

    if iscell(result)
        result = result{1, 1};
    end

    isHuman = logical(result);

end
