%% Given all analytic results, render/visualise the result
% Parameters:
% FPS (integer) - frame per second
% results(struct) - containing the results and the original video
function visualisation(results, FPS)
    LCS = results.LCS;
    NMS = results.NMS;
    nRows = 2;
    nColumns = 3;

    % Figure display full screen
    % reference https://uk.mathworks.com/matlabcentral/answers/63162-what-does-this-code-mean-set-gcf-units-normalized-outerposition-0-0-1-1
    figure('units', 'normalized', 'outerposition', [0, 0, 1, 1])

    % Display images for each frame
    for frameIndex = 1:size(results.origin, 4)
        % wait for the interval
        pause(1 / FPS);

        % Display original image
        presentOriginal(results.origin, frameIndex, nRows, nColumns);

        % Display LCS
        presentLCS(LCS(frameIndex), nRows, nColumns);

        % Display NMS
        presentNMS(NMS(frameIndex), nRows, nColumns);

    end

end
