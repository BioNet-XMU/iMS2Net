function netDCN = DCN_Net(matCoDCN,lsOrganName,dbThre)
figure();

nOrgan = length(lsOrganName);
% matNodeColor = [1,0,0;0,1,0;0,0,1;1,0,1;1,1,0;0,1,1;0,0,0;];
matNodeColor = jet(nOrgan);

netDCN = zeros(nOrgan,nOrgan);
matRat = zeros(nOrgan,nOrgan);
cvNode = sum(matCoDCN,2);

for i=1:nOrgan-1
    for j=i+1:nOrgan
         netDCN(i,j) = sum(matCoDCN(i,:).* matCoDCN(j,:));
         matRat(i,j)  = netDCN(i,j)/min(cvNode(i),cvNode(j));
    end
end
netDCN = netDCN + netDCN';
matRat = matRat + matRat';

netDCN = netDCN/max(cvNode);

netDCN(matRat<dbThre) = 0;
cellNode = cell(nOrgan,1);
for i=1:nOrgan
    cellNode{i} = [lsOrganName{i},sprintf('(%d)',cvNode(i))];
end
nm = graph(netDCN,cellNode);
cvNode = cvNode/max(cvNode);

pe = plot(nm,'MarkerSize',cvNode * 20,'LineWidth',nm.Edges.Weight*10,'layout','force');
pe.EdgeColor = [0.1,0.1,0.1];
pe.NodeColor = matNodeColor(1:nOrgan,:); colormap(matNodeColor);
title('Organ Network from Number of Altered Ions');
set(gcf,'position',[200,200,600,500]);
pe.EdgeLabel=nm.Edges.Weight;

clear matRat cvNode nOrgan cellNode i j;