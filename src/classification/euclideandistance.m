function [dEuc] = euclideandistance(sample1, sample2)
    diffSum = 0;
    for i = 1:length(sample1)
        diffSum = diffSum + (sample1(i) - sample2(i)) ^ 2;
    end
    dEuc = sqrt(diffSum);
end

