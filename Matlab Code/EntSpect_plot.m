function EntSpect_plot(lsEntSpect_Ctr, lsEntSpect_Exp, lsOrganName)
figure();

nOrgan = length(lsOrganName);
arrMI = cell(1,2*nOrgan);
for i=1:nOrgan
    arrMI{2*i-1} = lsEntSpect_Ctr{i};
    arrMI{2*i}   = lsEntSpect_Exp{i};
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
violin(arrMI,'facecolor',matColor,'edgecolor','none');
set(gca,'xtick',rvIdx,'xticklabel',lsOrganName);
set(gcf,'position',[100,100,800,500]);
clear rvIdx arrMI;

figure();
cvTestC = zeros(nOrgan,1);
for i=1:nOrgan
    for k=1:nOrgan
        if k==i,continue;end
        [h,~] = ttest2(lsEntSpect_Ctr{i},lsEntSpect_Ctr{k},'Vartype','unequal','Tail','right','Alpha',0.01);
        cvTestC(i) = cvTestC(i) + h;
    end
end

cvTestE = zeros(nOrgan,1);
for i=1:nOrgan
    for k=1:nOrgan
        if k==i,continue;end
        [h,~] = ttest2(lsEntSpect_Exp{i},lsEntSpect_Exp{k},'Vartype','unequal','Tail','right','Alpha',0.01);
        cvTestE(i) = cvTestE(i) + h;
    end
end

bar([1+cvTestC,1+cvTestE]);
set(gca,'xtick',(1:nOrgan),'xticklabel',lsOrganName,'ylim',[0,8]);
set(gcf,'position',[100,100,800,500]);