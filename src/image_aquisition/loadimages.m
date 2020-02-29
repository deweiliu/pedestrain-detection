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

imgs.paths=ImagePaths(directory);
imgs.number=size(imgs.paths,1);
imgs.images=ReadImages(imgs.paths,imgs.number);
imgs.grayImages=colour2gray(imgs.images,imgs.number);
imgs.nRows=size(imgs.grayImages(:,:,1),1);
imgs.nColumns=size(imgs.grayImages(:,:,1),2);
end


%% Given coloured images, convert them into gray images
function grayImages=colour2gray(images,number)
    grayImages=uint8.empty;
    for index=1:number    
        colouredImage=images(:,:,:,index);
        grayImage=rgb2gray(colouredImage);
        grayImages(:,:,index)=grayImage;
    end    
end

%% Given paths of images, read them
function images=ReadImages(paths,size)
    images=uint8.empty;
    for index=1:size
        image=imread(paths(index));
   
        % If the image is 2D, convert it into 3D
        if IsColour(image)==false
            image=gray2colour(image);
        end 
        images(:,:,:,index)=image;
       
    end
end

%% Given an image, checks if it is colour
function isColour=IsColour(image)
if size(size(image),2)==3
    isColour=true;
else
    isColour=false;
end
end
%% Given an grayscale image, converts it into coloured image (3D)
function colouredImage=gray2colour(image)
% reference https://uk.mathworks.com/matlabcentral/answers/86854-how-to-convert-a-gray-scale-image-to-color-image-using-matlab
colouredImage = cat(3, image, image, image);
end

%% Given a directory, returns the paths of images in this directory
function paths=ImagePaths(directory)
    % reference https://uk.mathworks.com/help/matlab/ref/dir.html
    images=dir(directory);
    paths=[];
    nImages=size(images);
    for index=1:nImages

        name=images(index).name;
        if IsImage(name)
            folder=images(index).folder;
            imagePath=folder+"/"+name;
            paths=[paths;imagePath];
        end
    end    
end

%% Given a name of a file, determines whether it is an image
function isImage=IsImage(fileName)
pattern=".jpg";

% reference https://uk.mathworks.com/help/matlab/ref/contains.html
if contains(fileName,pattern)
    isImage=true;
else
    isImage=false;
end
end