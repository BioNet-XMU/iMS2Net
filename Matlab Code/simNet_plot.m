function simNet_plot(matSim,lsOrganName,numPixel,dbThreRatio)
if dbThreRatio > 1.0,dbThreRatio=1.0;end
if dbThreRatio < 0.0,dbThreRatio=0.0;end

cvSizeNorm = 128 * numPixel/max(numPixel);
matColor = jet(128);

% Normalize the similarity score
matSim = matSim/max(matSim(:));

figure();
matSim(matSim < dbThreRatio) = 0;

fc = graph(matSim,lsOrganName);
pc = plot(fc,'LineWidth',10.0 * fc.Edges.Weight,'MarkerSize',ceil(cvSizeNorm/5),'NodeColor',matColor(ceil(cvSizeNorm),:),'NodeFontSize',12);

cvColor = discretize(fc.Edges.Weight,126);
pc.EdgeColor = matColor(cvColor,:); colormap(jet);

title('Organ similarity network');
set(gcf,'position',[200,200,600,500])

% XData = pc.XData;YData = pc.YData;
% save('D:\MSI\Fetus\OrgNet\dataPosition.mat','XData','YData');