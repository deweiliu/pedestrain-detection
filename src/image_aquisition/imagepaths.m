%% Given a directory, returns the paths of images in this directory
function paths = imagepaths(directory)
    % reference https://uk.mathworks.com/help/matlab/ref/dir.html
    images = dir(directory);
    paths = [];
    nImages = size(images);

    for index = 1:nImages

        name = images(index).name;

        if IsImage(name)
            folder = images(index).folder;
            imagePath = folder + "/"+ name;
            paths = [paths; imagePath];
        end

    end

end

%% Given a name of a file, determines whether it is an image
function isImage = IsImage(fileName)
    pattern = ".jpg";

    % reference https://uk.mathworks.com/help/matlab/ref/contains.html
    if contains(fileName, pattern)
        isImage = true;
    else
        isImage = false;
    end

end
