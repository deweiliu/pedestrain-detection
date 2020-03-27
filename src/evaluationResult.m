%% Clear the console and environment
clear result
close all

%% Load the scripts from subfolders
% reference https://uk.mathworks.com/help/matlab/ref/genpath.html
paths = genpath("./");
addpath(paths);

%% Create output directory
output = "../output";
makedir(output);

%% Load result
try
    load("result.mat");
catch
    % https://uk.mathworks.com/help/matlab/ref/try.html
    fprintf("Unable to load result.mat. Please make sure you have executed main.m\n");
    return
end

%% Present the result
FRAME_PER_SECOND = 10;

evaluation(result, FRAME_PER_SECOND);
