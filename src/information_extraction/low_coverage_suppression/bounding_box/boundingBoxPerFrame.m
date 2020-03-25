function [bounding, data] = boundingBoxPerFrame(labelledImage, originImage)
    boxes = [];
    image = originImage;

    for boundingIndex = 1:labelledImage.number
        % For each bounding box in the image/frame
        % reference CSC3061 Practical 3

        % Calculate the current bounding box
        [Ys, Xs] = find(labelledImage.labels == boundingIndex);
        box.x = min(Xs);
        xmax = max(Xs);
        box.width = xmax - box.x + 1;
        box.y = min(Ys);
        ymax = max(Ys);
        box.height = ymax - box.y + 1;

        % Save the bounding box
        boxes = [boxes; box];

        % Add the bounding box to the image
        image = mergeImageBounding(image, box, "green");
    end

    bounding.frameIndex = labelledImage.frameIndex;
    bounding.title = sprintf("%d pedestrians detected", labelledImage.number);
    bounding.image = image;
    bounding.number = labelledImage.number;
    bounding.boxes = boxes;
    data = boxes;

end
