function Violin_DEI(lsDEI, numPixel_Exp, lsOrganName)
figure();
iMax = max(lsDEI);
nOrgan = length(lsOrganName);

cellViolin = cell(nOrgan,1);
nTem = 0;
for i=1:nOrgan
    cellViolin{i} = lsDEI(nTem+1:nTem+numPixel_Exp(i));
    nTem = nTem+numPixel_Exp(i);
end

violin(cellViolin');
set(gca,'xtick',(1:nOrgan),'xticklabel',lsOrganName,'ylim',[-10,iMax+20]);
ylabel('Significant Ions Number')
set(gcf,'position',[200,200,800,600]);

clear nTem nOrgan cellViolin i;