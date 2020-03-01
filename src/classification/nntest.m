function [result] = nntest(pedestrians, model)
    for i=1:pedestrians.number
        testSample = pedestrians.features(i, :);
        minDistance = Inf(1);
        for j=1:model.number
            comparison = model.features(j, :);
            totalDistance = 0;
            for k=1:length(comparison)
                testValue = testSample(k);
                comparisonValue = comparison(k);
                totalDistance = totalDistance + (testValue - comparisonValue)^2;
            end
            if sqrt(totalDistance) < minDistance
                minDistance = sqrt(totalDistance);
                result(i) = model.labels(j);
            end
        end
    end
end