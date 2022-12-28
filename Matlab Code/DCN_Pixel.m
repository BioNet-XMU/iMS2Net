function lsDCN = DCN_Pixel(msiDataOrgan_Exp, msiDataOrgan_Ctr,numPixel_Exp,alpha)

dbMinRatio = 0.2;

nOrgan = length(msiDataOrgan_Exp);

lsDCN = zeros(sum(numPixel_Exp),1);
nCount = 0;
for i=1:nOrgan
    [cellSSN,cvLinkRatio] = SSN_PCC(msiDataOrgan_Ctr{i},msiDataOrgan_Exp{i},alpha);
    
    nSample = size(msiDataOrgan_Exp{i},1);
    lsDCN(nCount+1:nCount+nSample) = subEnrichNode(cellSSN,cvLinkRatio,dbMinRatio);
    nCount = nCount+nSample;
end

clear dbMinRatio nCount nOrgan i nSample cellSSN cvLinkRatio;