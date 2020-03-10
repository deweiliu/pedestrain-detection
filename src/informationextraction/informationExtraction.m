function results = informationExtraction(pedestrians, threshold,connectivity)
	methods=["label_HOG_SVM"];
	
    % To show results for both HOG_SVM & HOG_KNN, uncomment the line below 
    % methods=["label_HOG_SVM";"label_HOG_KNN"];
    results=[];
    % For each method
    for methodIndex=1:size(methods,1)
        
        % Calculate the images
        method=methods(methodIndex);
        
        result.method=method;
    result.slidingCounting = highlightSliding(pedestrians,method);
    result.labels = labelling(result.slidingCounting, threshold,connectivity);
result.boundings=boundingBox(result.labels,pedestrians);


results=[results;result];
    end
end
