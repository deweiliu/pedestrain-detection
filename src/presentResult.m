%% Clear the console and environment
clear all
close all

%% Load the scripts from subfolders
% reference https://uk.mathworks.com/help/matlab/ref/genpath.html
paths = genpath("./");
addpath(paths);

%% Create output directory
output = "../output";
makedir(output);

%% Load result
load("result.mat");
% Present the result
FRAME_PER_SECOND = 5;
presentation(result, FRAME_PER_SECOND);
