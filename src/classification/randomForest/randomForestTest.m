function randomForestTest(model)
    figure;
    oobErrorBaggedEnsemble = oobError(model);
    plot(oobErrorBaggedEnsemble)
    xlabel 'Number of grown trees';
    ylabel 'Out-of-bag classification error';

end
