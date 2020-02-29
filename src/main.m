% Main matlab script

%% Clear the console and environment
clear all
close all

%% Load matlab script from subfolders
addpath("./utilities");

%% Read Images
pedestrians=loadimages("../dataset/pedestrian/");
positives=loadimages("../dataset/images/pos/");
negatives=loadimages("../dataset/images/neg/");
