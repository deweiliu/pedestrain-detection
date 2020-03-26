function rfFigure = rfTunning(features, labels)
    dependentValues = table2array(features);

    model = TreeBagger(60, dependentValues, labels, 'OOBPrediction', 'On', 'Method', 'classification');

    rfFigure = figure(1);
    oobErrorBaggedEnsemble = oobError(model);
    plot(oobErrorBaggedEnsemble)
    title("Random Forest Parameter Tunning");
    xlabel('Number of grown trees');
    ylabel('Out-of-bag classification error');

end
