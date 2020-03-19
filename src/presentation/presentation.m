%% Given all analytic results, render/visualise the result
% Parameters:
% FPS (integer) - frame per second
% pedestrians(struct) - containing the results and the original video
function presentation(pedestrians, FPS)
    LCSResult = pedestrians.results.LCS;
    nFrames = pedestrians.number;
    nResults = size(LCSResult, 1);
    nRows = 1 + nResults;
    nColumns = 4;

    % Figure display full screen
    % reference https://uk.mathworks.com/matlabcentral/answers/63162-what-does-this-code-mean-set-gcf-units-normalized-outerposition-0-0-1-1
    figure('units', 'normalized', 'outerposition', [0, 0, 1, 1])

    % Display images for each frame
    for frameIndex = 1:nFrames
        % wait for the interval
        pause(1 / FPS);

        % Display original image
        presentOriginal(pedestrians.images, frameIndex, nRows, nColumns);

        % Display result(s)
        for resultIndex = 1:nResults
            plotIndex = resultIndex * nColumns + 1;
            presentResult(LCSResult(resultIndex), frameIndex, nRows, nColumns, plotIndex);

        end

    end

end
