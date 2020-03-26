function predictions = rfTest(model)
    predictions = oobPredict(model);
    predictions = cell2logical(predictions);
end
