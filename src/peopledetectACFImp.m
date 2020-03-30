%% Before running this script
% You have to ensure section 1 "main.m" have been run

%% Implement peopledetectACF
detector = peopleDetectorACF;
newPedestriansImages = pedestrians.images;
for frameIndex = 1:size(newPedestriansImages, 4)
    [bboxes,scores] = detect(detector,newPedestriansImages(:,:,:,frameIndex));
    newPedestriansImages(:,:,:,frameIndex) = insertObjectAnnotation(newPedestriansImages(:,:,:,frameIndex),'rectangle',bboxes,scores);
end

%% Save result as a video file
videoFile = "../output/videoPeopleDetectACF.mp4";
output = VideoWriter(convertStringsToChars(videoFile), 'MPEG-4');
output.FrameRate = 3;
open(output);

for i = 1:size(newPedestriansImages, 4)
    img = newPedestriansImages(:, :, :, i);
    writeVideo(output, img);
end
close(output);