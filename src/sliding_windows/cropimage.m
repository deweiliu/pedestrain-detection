% References:
% https://uk.mathworks.com/help/images/ref/imcrop.html
% https://uk.mathworks.com/help/matlab/ref/mexception.throw.html
function cropedImage = cropimage(image, position)
    % Given an image of the position to crop, returns the croped image
    % image: 3-D image
    % position: position to crop

    % extract data
    x = position(1);
    y = position(2);
    width = position(3);
    height = position(4);

    % save data
    output.position = position;
    output.x = x;
    output.y = y;
    output.width = width;
    output.height = height;
    output.topLeft = [x, y];
    output.topRight = [x + width - 1, y];
    output.bottomLeft = [x, y + height - 1];
    output.bottomRight = [x + width - 1, y + height - 1];
    output.label_HOG = 0;
    output.features_HOG = 0;

    % BUG in matlab  '9.6.0.1135713 (R2019a) Update 3:
    % in function imcrop()
    % the class(rectangle) must be 'double'
    rectangle = double([output.x, output.y, output.width - 1, output.height - 1]);
    output.image = imcrop(image, double(rectangle));

    % check if the cropping performs correctly
    actualHeight = size(output.image, 1);
    actualWidth = size(output.image, 2);

    if actualHeight ~= output.height || actualWidth ~= output.width
        ME = MException('cropimage:outOfIndex', 'Sliding window position = %s does not fit the image size of %s', mat2str(position), mat2str(size(image)));
        throw(ME);
    end

    % output
    cropedImage = output;

end
