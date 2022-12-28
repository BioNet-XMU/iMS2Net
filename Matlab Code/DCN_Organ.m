function matCoDCN = DCN_Organ(msiDataOrgan_Exp, msiDataOrgan_Ctr, alpha)
nOrgan = length(msiDataOrgan_Exp);
nIon = size(msiDataOrgan_Exp{1},2);

matCoDCN = zeros(nOrgan,(nIon)*(nIon-1)/2);
for i=1:nOrgan
    [matTC1,matP] = corr(msiDataOrgan_Ctr{i});
    matTC1(matP>alpha) = 0;
    nFC = size(msiDataOrgan_Ctr{i},1);
    
    [matTC2,matP] = corr(msiDataOrgan_Exp{i});
    matTC2(matP>alpha) = 0;
    nFE = size(msiDataOrgan_Exp{i},1);
    
    matTC1 = 0.5 * log((1+matTC1)./(1-matTC1));
    matTC2 = 0.5 * log((1+matTC2)./(1-matTC2));
    matTC1(isinf(matTC1))=0;matTC1(isnan(matTC1))=0;
    matTC2(isinf(matTC2))=0;matTC2(isnan(matTC2))=0;
    
    % 绠楄仈鍚?
    matTC = abs(matTC2-matTC1)/(sqrt(1/(nFE-3) + 1/(nFC-3)));

    cvTC = mafdr(1-normcdf(matTC(:)),'BHFDR',true); % FDR 校正，2022-07-02
    matTC(:) = 0;
    matTC(cvTC<alpha) =1;

    matCoDCN(i,:) = TriMatrix2Vector(matTC);
end
clear matTC1 matTC2 matP matTC cvTC nFE nFC nOrgan nIon i;