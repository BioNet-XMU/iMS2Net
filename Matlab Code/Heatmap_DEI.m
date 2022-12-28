function Heatmap_DEI(lsDEI,lblPixel_Exp)
iMax = max(lsDEI)+1;

figure()
matColor = jet(iMax);
matColor(end,:) = [1,1,1];

[nRow,nCol] = size(lblPixel_Exp);
nOrgan = max(lblPixel_Exp(:));

matX = iMax * ones(nRow*nCol,1);
nTem = 0;
cvLbl = lblPixel_Exp(:);
matX(cvLbl==0)=1;
for k=1:nOrgan
    nPixel = sum(cvLbl==k);
    matX(cvLbl==k) = lsDEI(nTem+1:nTem+nPixel);
    nTem = nTem+nPixel;
end
matX = reshape(matX,[nRow,nCol]);

imagesc(matX);colormap(matColor);colorbar;

set(gcf,'position',[200,200,nCol*4+50,nRow*4]);
box off; axis off;

clear iMax matColor nTem nRow nCol k nOrgan matX;
end