function [dEuc] = euclideandistance(firstSampleRow, secondSampleRow)
    diffSum = 0;
    for i = 1:width(firstSampleRow)
        diffSum = diffSum + (firstSampleRow{1, i} - secondSampleRow{1, i}) ^ 2;
    end
    dEuc = sqrt(diffSum);
end

