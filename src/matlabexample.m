%% Matlab Example script
% https://uk.mathworks.com/help/vision/examples/tracking-pedestrians-from-a-moving-car.html
% This script makes use of an example matlab script to identify pedestrians

%% Set up Environment
setupEnvir;

%% Write the video file
videoFile = "../output/video.mp4";
output = VideoWriter(convertStringsToChars(videoFile), 'MPEG-4');
output.FrameRate = 10;
open(output);

for i = 1:pedestrians.number
    img = pedestrians.images(:, :, :, i);

    writeVideo(output, img);
end
close(output);

%% Run the example matlab script
PedestrianTrackingFromMovingCameraExample(videoFile, pedestrians);
