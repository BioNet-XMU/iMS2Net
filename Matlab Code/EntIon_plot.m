function EntIon_plot(matEntIon_Ctr, matEntIon_Exp, lsMZ, lsOrganName)
[nOrgan,nIon] = size(matEntIon_Ctr);
matMI = zeros(nIon,2*nOrgan);
for i=1:nOrgan
    matMI(:,2*i-1) = matEntIon_Ctr(i,:)';
    matMI(:,2*i)   = matEntIon_Exp(i,:)';
end

matCol = jet(nOrgan);
matColor = zeros(2*nOrgan,3);
for i=1:nOrgan
    matColor(2*i-1,:) = matCol(i,:);
    matColor(2*i,:)   = matCol(i,:);
end
clear matCol;
% matColor = [1,0,0;1,0,0;...
%     0,1,0;0,1,0;...
%     0,0,1;0,0,1;...
%     1,0,1;1,0,1;...
%     1,1,0;1,1,0;...
%     0,1,1;0,1,1;...
%     0,0,0;0,0,0];
rvIdx = (1:2:2*nOrgan) + 0.5;

figure();
violin(matMI,'facecolor',matColor,'edgecolor','none');
set(gca,'xtick',rvIdx,'xticklabel',lsOrganName); %'ylim',[1.3,5.5],
ylabel('Entropy');
set(gcf,'position',[100,100,800,500]);


figure(); % 显示
[cvMZ,cvInd]=sort(lsMZ,'ascend');
matMI = matMI(cvInd,:);

imagesc(matMI');
colormap(jet(16));

rvIndex = 200:100:(floor(cvMZ/100)*100);
nXLabel = length(rvIndex);
cellLabel = cell(nXLabel,1);
rvXTick = zeros(nXLabel,1);
for i=1:nXLabel
    [~,rvXTick(i)]= min(abs(cvMZ-rvIndex(i)));
    cellLabel{i} = sprintf('%d',rvIndex(i));
end

cellOrg = cell(1,2 * nOrgan);
for i=1:nOrgan
    cellOrg{2*i-1} = [lsOrganName{i},'(Ctr)'];
    cellOrg{2*i} = [lsOrganName{i},'(Exp)'];
end
set(gca,'xtick',rvXTick,'xticklabel',cellLabel,'ytick',1:14,'yticklabel',cellOrg);
xlabel('m/z');
set(gcf,'position',[100,100,880,500]);

clear cellOrg rvIndex nXLabel rvXTick matMI rvIdx matColor