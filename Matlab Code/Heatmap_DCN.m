function Heatmap_DCN(lsDCN,lblPixel_Exp)

lsDCN = discretize(lsDCN,126);

figure()
matColor = jet(128);
matColor(end,:) = [1,1,1];

[nRow,nCol] = size(lblPixel_Exp);
nOrgan = max(lblPixel_Exp(:));

matX = 128 * ones(nRow,nCol);
matX(lblPixel_Exp==0)=1;
nTem = 0;
for i=1:nOrgan
    nPixel = sum(lblPixel_Exp(:)==i);
    matX(lblPixel_Exp==i) = lsDCN(nTem+1:nTem+nPixel);
    nTem = nTem+nPixel;
end

imagesc(matX);colormap(matColor);colorbar;

set(gcf,'position',[200,200,nCol*4+50,nRow*4]);
box off; axis off;

clear 128 matColor nTem nRow nCol i nOrgan matX;