%% Given all analytic results, render/visualise the result
% Parameters:
% FPS (integer) - frame per second
% pedestrians(struct) - containing the results and the original video
function presentation(pedestrians, FPS)
    LCS = pedestrians.results.LCS;
    NMS = pedestrians.results.NMS;
    nRows = 3;
    nColumns = 4;

    % Figure display full screen
    % reference https://uk.mathworks.com/matlabcentral/answers/63162-what-does-this-code-mean-set-gcf-units-normalized-outerposition-0-0-1-1
    figure('units', 'normalized', 'outerposition', [0, 0, 1, 1])

    % Display images for each frame
    for frameIndex = 1:pedestrians.number
        % wait for the interval
        pause(1 / FPS);

        % Display original image
        presentOriginal(pedestrians.images, frameIndex, nRows, nColumns);

        % Display LCS
        plotIndex = nColumns + 1;
        presentLCS(LCS(frameIndex), nRows, nColumns, plotIndex);

    end

end
