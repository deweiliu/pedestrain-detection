addpath("../image_aquisition");
pedestrians = loadimages("../../dataset/pedestrian/");

videoFile = "../output/video.mp4";
mkdir("../output");
output = VideoWriter(convertStringsToChars(videoFile), 'MPEG-4');
output.FrameRate = 10;
open(output);

for i = 1:pedestrians.number
    img = pedestrians.images(:, :, :, i);

    writeVideo(output, img);
end

close(output);

PedestrianTrackingFromMovingCameraExample(videoFile, pedestrians);
