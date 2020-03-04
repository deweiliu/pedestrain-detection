clear all
close all
addpath("./segmentation");
pedestrians = loadimages("../dataset/pedestrian/");
scales=[1,2];

%%
%%
o=slidingWindowsParams(pedestrians,96,160,scales,0.1);

%%



return;













i=pedestrians.images(:,:,:,50);
width2height_radio=96/160;
width=96;
height=160;
scales=1;

imshow(i);
%%
addpath("./segmentation");
y=10;
cropWidth=100;
cropHeight=100;
gap=50;
horizontalGap=gap;
verticalGap=gap;

objects=slidingWindowsParams(i,cropWidth,cropHeight,horizontalGap,verticalGap);

[rows,columns,frames]=size(objects);
%%
figure;
for row=1:rows
    for column=1:columns
        index=(row-1)*columns+column;
        subplot(rows,columns,index);
        imshow(objects(row,column).image);
        title(['(',num2str(row),', ',num2str(column),')']);
        
    end
end