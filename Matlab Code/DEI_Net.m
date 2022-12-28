function netDEI = DEI_Net(matCoDEI,lsOrganName,dbThre)
figure();

nOrgan = length(lsOrganName);
% matNodeColor = [1,0,0;0,1,0;0,0,1;1,0,1;1,1,0;0,1,1;0,0,0;];
matNodeColor = jet(nOrgan);

netDEI = zeros(nOrgan,nOrgan);
matRat = zeros(nOrgan,nOrgan);
cvNode = sum((matCoDEI~=0),2);

for i=1:nOrgan-1
    for j=i+1:nOrgan
         netDEI(i,j) = sum((matCoDEI(i,:)~=0)&(matCoDEI(j,:)~=0));
         matRat(i,j)  = netDEI(i,j)/min(cvNode(i),cvNode(j));
    end
end
netDEI = netDEI + netDEI';
matRat = matRat + matRat';

netDEI(matRat<dbThre) = 0;
cellNode = cell(nOrgan,1);
for i=1:nOrgan
    cellNode{i} = [lsOrganName{i},sprintf('(%d)',cvNode(i))];
end
nm = graph(netDEI,cellNode);

pe = plot(nm,'MarkerSize',1.8*sqrt(cvNode)+2,'LineWidth',nm.Edges.Weight/5,'layout','force');
pe.EdgeColor = [0.1,0.1,0.1];
pe.NodeColor = matNodeColor(1:nOrgan,:); colormap(matNodeColor);
title('Organ Network from Number of Altered Ions');
set(gcf,'position',[200,200,600,500]);
pe.EdgeLabel=nm.Edges.Weight;

clear matRat cvNode nOrgan cellNode i j;