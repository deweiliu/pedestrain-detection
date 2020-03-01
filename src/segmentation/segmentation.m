function segmentated=segmentation(images)
% TODO function for segmentation
segmentated=images;

for t = 2:images.number
previousFrameGray =  double(images.grayImages(:,:,t-1));


currentFrameGray = double(images.grayImages(:,:,t));



[u, v] = HS(previousFrameGray, currentFrameGray);

% step 3
figure(1);
subplot(1, 3, 1), imshow(previousFrameGray, [0, 255]);
hold on
quiver(u, v, 4, "color", "blue", "linewidth", 2);
set(gca, "YDir", "reverse");
hold off

% step 5
magnitude = sqrt(u.^2 + v.^2);
velocity_threhold = 3;
blobs = magnitude >= velocity_threhold;
subplot(1, 3, 2), imshow(blobs);

% step 6
mask = ones(3, 3);
blobs = imclose(blobs, mask);
blobs = imopen(blobs, mask);
subplot(1, 3, 3), imshow(blobs);

end

end