
function rowImages=slidingrow(image,y,cropWidth,cropHeight,gap)
imgWidth=size(image,2);

rowImages=[];
for x=1:gap:(imgWidth-cropWidth+1)
position=[x,y,cropWidth,cropHeight];
cropedImage=cropimage(image,position);
rowImages=[rowImages,cropedImage];
end
end
