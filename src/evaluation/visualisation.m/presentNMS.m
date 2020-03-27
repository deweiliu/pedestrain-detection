function presentNMS(NMS_IoU, NMS_IoM, nRows, nColumns)
    displayImage(NMS_IoU.image, nRows, nColumns, 2);
    displayImage(NMS_IoM.image, nRows, nColumns, 3);
end
