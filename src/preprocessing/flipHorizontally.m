%% Flip the image vertically
%% Parameters
% inputImage - uint8 images file
%% Return
% outputImage - uint8 images file
function [outputImage] = flipHorizontally(inputImage)
outputImage = flip(inputImage,2);
end
