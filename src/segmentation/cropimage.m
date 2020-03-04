function cropedImage=cropimage(image,position)
output.position=position;
output.x=position(1);
output.y=position(2);
output.width=position(3);
output.height=position(4);

output.image=imcrop(image,[output.x,output.y,output.width-1,output.height-1]);

[height,width,colours]=size(output.image);

if height~=output.height || width~=output.width

    ME = MException('cropimage:outOfIndex',        'Image size = %s while position = %s',mat2str(size(image)),mat2str(position));
    throw(ME);
end
cropedImage=output;

end