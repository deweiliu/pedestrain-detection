%% Before running this script
% You have to ensure section 1, 2 and 3 in "main.m" have been run

VISUALIZATION_DIRECTORY=fullfile(output,"pcaVisualization");
makedir(VISUALIZATION_DIRECTORY);

%% Implement PCA to reduce dimensionality of feature HOG
% first col is the label, second col is the name
labels = features.HOG(:,1);
labels = table2array(labels);
% the rest is feature info
featureData = features.HOG(:,3:end);
featureData = table2array(featureData);
[eigenVectors, eigenvalues, meanX, Xpca] = PrincipalComponentAnalysis(featureData, 2);

%% visualize the output
gscatter(Xpca(:,1),Xpca(:,2),labels)
title("PCA visualization"), xlabel("pc 1"), ylabel("pc 2")
saveas(gcf, fullfile(VISUALIZATION_DIRECTORY, 'PCAvisualization.jpg'));

