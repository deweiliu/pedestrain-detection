function [result] = generateOrLoadFeature(fileLoad, metaTable, positives, negatives, file, featureFunc, args)
    if fileLoad == true && ~exist(file, "file") == 0
        fprintf('Found "%s" feature file, skipping generation and loading from file\n', file);
        result = readtable(file);
    else
        if fileLoad == true
            fprintf('No "%s" feature file found, generating a new one\n', file);
        end
        result = [];
        fprintf('Generating features for positive data\n');
        % feature generation for positive original images
        for i=1:length(positives.images)
            image = positives.images(:,:,:,i);
            result = [result; featureFunc(image, args{:})];
        end
        % feature generation for positive processing images
        for i=1:length(positives.processedImages.contrastingFlipHorImages)
            image = positives.processedImages.contrastingFlipHorImages(:,:,:,i);
            result = [result; featureFunc(image, args{:})];
        end
        
        fprintf('Generating features for negative data\n');
        % feature generation for negative original images
        for i=1:length(negatives.images)
            image = negatives.images(:,:,:,i);
            result = [result; featureFunc(image, args{:})];
        end
        % feature generation for negative processing images
        for i=1:length(negatives.processedImages.contrastingFlipHorImages)
            image = negatives.processedImages.contrastingFlipHorImages(:,:,:,i);
            result = [result; featureFunc(image, args{:})];
        end
        
        % Convert to table
        result = array2table(result);
        
        % Add metadata (labels and image names)
        result = [metaTable, result];
        
        if fileLoad == true
            fprintf('Saving feature file...\n');
            writetable(result, file);
            fprintf('Finished saving "%s" feature file\n', file);
        end
    end
end

