%% Enhance the contrast of input image
%% Parameters
% inputImage - uint8 images file
%% Return
% outputImage - uint8 images file
function [outputImage] = contrastStretch(inputImage)
outputImage = imadjust(inputImage,stretchlim(inputImage));
end

