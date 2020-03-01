%% References
% https://uk.mathworks.com/help/imaq/examples/live-motion-detection-using-optical-flow.html
% https://uk.mathworks.com/help/vision/ref/opticalflowhs.estimateflow.html
%% Segmentation function
% Given image object
% Return binary images indicating the optical flow in each image
% * |pedestrians| :   Object returned by image_aquisition.loadimages()
% * |pedestrians| :   true of false, indicating if the segmentation result is displayed
%
function segmentated = segmentation(pedestrians, isDisplay)

    % Threshold for flow vector to detect movement
    THRESHOLD = 0.1;
    % Segementation parameter 1 or 2 or 3 or 4
    % Indicating until which post-precessing step to do for the segmentation
    SEG_PARA = 4;

    opticFlow = opticalFlowHS;

    for frameNo = 1:pedestrians.number
        frame = pedestrians.images(:, :, :, frameNo);
        flow = estimateFlow(opticFlow, rgb2gray(frame));

        % Image with flow vectors
        image1.frame = frame;
        image1.flow = flow;
        image1.title = "Original Optical Flow";

        % Optimised flow
        meanx = mean(flow.Vx);
        Vx = flow.Vx - meanx;
        meany = mean(flow.Vy);
        Vy = flow.Vy - meany;
        optimisedFlow = opticalFlow(Vx, Vy);
        image2.frame = frame;
        image2.flow = optimisedFlow;
        image2.title = "Optimised Flow";

        % post-processing step 1
        % Do nothing but calculate the blobs
        blobs = optimisedFlow.Magnitude > THRESHOLD;
        image3.frame = blobs;
        image3.title = sprintf("Segmentation threshold = %.2f", THRESHOLD);

        % post-processing step 2
        % close -> open
        mask = ones(3, 3);
        optimisedBlobs = blobs;
        optimisedBlobs = imclose(optimisedBlobs, mask);
        optimisedBlobs = imopen(optimisedBlobs, mask);
        image4.frame = optimisedBlobs;
        image4.title = "close and open";

        % post-processing step 3
        % fill the holes
        filledBlobs = imfill(blobs, 8, 'holes');
        image5.frame = filledBlobs;
        image5.title = "fill holes";

        % ooptimise blob 4
        % close -> open -> fill the holes again
        blobs3 = filledBlobs;
        blobs3 = imclose(blobs3, mask);
        blobs3 = imopen(blobs3, mask);
        blobs3 = imfill(blobs3, 8, 'holes');
        image6.frame = blobs3;
        image6.title = "close, open and fill holes";

        % save the result
        images = {image1, image2, image3, image4, image5, image6};

        segmentated(:, :, frameNo) = images{SEG_PARA + 2}.frame;
        % display
        if nargin < 2
            isDisplay = false;
        end

        if isDisplay
            display(images, frameNo);
        end

    end

end

function display(images, frameNo)
    figure(1);
    rows = 2;
    columns = 3;

    for index = 1:size(images, 2)
        subplot(rows, columns, index);

        target = images{index};
        imshow(target.frame)
        titleText = sprintf(" Frame No.%d\n"+target.title,frameNo);
        title(titleText);

        if isfield(target, 'flow')

            hold on
            plot(target.flow, 'DecimationFactor', [5 5], 'ScaleFactor', 25)
            hold off

        end

    end

    pause(0.1);
end
