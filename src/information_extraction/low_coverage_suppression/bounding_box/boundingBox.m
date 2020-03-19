function boundings = boundingBox(labelledImages, pedestrians)
    nFrames = pedestrians.number;
    boundings = [];

    for frameIndex = 1:nFrames
        originImage = pedestrians.images(:, :, :, frameIndex);
        bounding = boundingBoxPerFrame(labelledImages(frameIndex), originImage);
        boundings = [boundings; bounding];
    end

end
