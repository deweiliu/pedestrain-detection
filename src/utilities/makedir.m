% reference https://uk.mathworks.com/help/matlab/ref/mkdir.html
function isExist = makedir(directory)

    if exist(directory, 'dir') == 0
        fprintf("Creating new directory %s\n", directory);
        isExist = false;
        mkdir(directory);
    else
        isExist = true;
    end

end
