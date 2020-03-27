% reference https://uk.mathworks.com/help/vision/ref/insertshape.html#d118e166476
% Given an image and a bounding box (rectangle)
% add the rectangle onto the image
function newImage = mergeImageBounding(image, boundingBox, colour)
    box = [boundingBox.x, boundingBox.y, boundingBox.width, boundingBox.height];
    newImage = insertShape(image, 'rectangle', box, 'LineWidth', 5, 'Color', {colour});
end
