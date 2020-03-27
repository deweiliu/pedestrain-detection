function count = compareDatasetPerImage(test, prediction)
    count = 0;

    for index = 1:prediction.nPedestrians
        testIndex = comparePerBox(test, prediction.boxes(index, :));

        if testIndex ~= 0
            % Found a match
            test.boxes(testIndex, :) = [];
            count = count + 1;
        end

    end

end

function testIndex = comparePerBox(test, box)

    for testIndex = 1:size(test.boxes, 1)

        if isSameBox(test.boxes(testIndex, :), box)
            return;
        end

    end

    testIndex = 0;

end

function isSame = isSameBox(box1, box2)
    interction = rectint(box1, box2);
    area1 = box1(3) * box1(4);
    area2 = box2(3) * box2(4);

    if (interction > area1 / 2) | (interction > area2 / 2)
        isSame = true;
    else
        isSame = false;
    end

end
