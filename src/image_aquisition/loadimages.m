%% Given a directory, scan all images in this directory (not including sub directories)
% directory(string)- path to the directory
% return(struct)-
% field: paths - An array with the paths to the images
% field: number - Number of images
% field: images - 4D array, images(:,:,:,index) returns an coloured image
% field: grayImages - 3D array, grayImages(:,:,index) returns a grayscale image
% field: nRows - Number of rows in each image
% field: nColumns - Number of columns in each image
function imgs=loadimages(directory)
disp(fprintf("Loading images from %s\nPlease wait...",directory));

imgs.paths=imagepaths(directory);
imgs.number=size(imgs.paths,1);
imgs.images=readimages(imgs.paths,imgs.number);
imgs.grayImages=colour2gray(imgs.images,imgs.number);
imgs.nRows=size(imgs.grayImages(:,:,1),1);
imgs.nColumns=size(imgs.grayImages(:,:,1),2);
end
