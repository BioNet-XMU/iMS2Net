function lsDEI = DEI_Pxiel(msiDataOrgan_Exp,msiDataOrgan_Ctr,dbAlpha)

dbZscoreOutlier = 3;

nOrgan = length(msiDataOrgan_Exp);

cvFE = zeros(nOrgan,1);
for i=1:nOrgan
    cvFE(i) = size(msiDataOrgan_Exp{i},1);
end

nIon = size(msiDataOrgan_Exp{1},2);
rvMean = zeros(1,nIon);
rvStd = zeros(1,nIon);
cvT  = cumsum([0;cvFE]);
lsDEI = zeros(sum(cvFE),1);
for i=1:nOrgan    
    for k=1:nIon
        [rvMean(k),rvStd(k)] = subStaticsDeOutlier(msiDataOrgan_Ctr{i}(:,k), dbZscoreOutlier);
    end

    rvStd(rvStd<=0)=1;
    matZscore = msiDataOrgan_Exp{i};

    matM = repmat(rvMean,[cvFE(i),1]);
    matS = repmat(rvStd,[cvFE(i),1]);
    matZscore = abs(matZscore-matM)./matS;         % 寰楀埌 zscore 鐨勭粷瀵瑰??

    cvTem = mafdr(1-normcdf(abs(matZscore(:))),'BHFDR',true);
    cvQ = cvTem; cvQ(:)=0;
    cvQ(cvTem<dbAlpha)=1;
    lsDEI(cvT(i)+1:cvT(i+1)) = sum(reshape(cvQ,size(matZscore)),2);    
end

clear dbZscoreOutlier nOrgan cvFE nIon rvMean rvStd cvT matZscore matM matS cvTem cvQ;