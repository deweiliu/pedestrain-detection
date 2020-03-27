%% Given one sliding window, return a matrix which has the pixels of the sliding window set to 1
% Parameters
% totalRows - the number of rows in the pedestrian image
% totalColumns - the number of columns in the pedestrian image
% window- The sliding window which was detected as a pedestrian
%
% Return:
% highlightedWindow (2-D matrix) which has only values 0 or 1
function highlightedWindow = highlightSlidingPerWindow(totalRows, totalColumns, window)
    highlightedWindow = zeros(totalRows, totalColumns);

    ymin = window.topLeft(2);
    ymax = window.bottomRight(2);

    xmin = window.topLeft(1);
    xmax = window.bottomRight(1);

    for row = ymin:ymax

        for column = xmin:xmax
            highlightedWindow(row, column) = 1;
        end

    end

    highlightedWindow = uint8(highlightedWindow);

end
