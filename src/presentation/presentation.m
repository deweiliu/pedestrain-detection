%% Given all analytic results, render/visualise the result
% Parameters:
% FPS (integer) - frame per second
% pedestrians(struct) - containing the results and the original video
function presentation(pedestrians,FPS)
results=    pedestrians.results;
nFrames=pedestrians.number;
nResults=size(results,1);
nRows=1+nResults;
nColumns=4;

% Figure display full screen
figure('units','normalized','outerposition',[0 0 1 1])


% Display images for each frame
for frameIndex=1:nFrames
% wait for the interval
pause(1/FPS);

% Display original image
presentOriginal(pedestrians.images,frameIndex,nRows,nColumns);

% Display result(s)
for resultIndex=1:nResults
    plotIndex=resultIndex*nColumns+1;
presentResult(results(resultIndex),frameIndex,nRows,nColumns,plotIndex);

end


end


end
