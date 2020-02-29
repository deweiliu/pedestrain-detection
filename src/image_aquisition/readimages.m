%% Given paths of images, read them
function images=readimages(paths,size)
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
