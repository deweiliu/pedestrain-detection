%% Optical Flow script

%% Set up Environment
setupEnvir;

%% Configurable parameters
% The speed of displaying the result
FRAME_PER_SECOND = 5;

%% Optical Flow
pedestrianOpticalFlow(pedestrians, FRAME_PER_SECOND);
