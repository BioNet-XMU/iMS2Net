function [lsEntSpect_Ctr, lsEntSpect_Exp] = Entropy_Spect(msiDataOrgan_Ctr, msiDataOrgan_Exp,numPixel_Ctr,numPixel_Exp)

nBin = 100; % 杩愯鏃堕棿 14绉?
dbZscoreOutlier = 3.0;

nOrgan = length(msiDataOrgan_Ctr);
nIon = size(msiDataOrgan_Ctr{1},2);

lsEntSpect_Ctr = cell(nOrgan,1);
lsEntSpect_Exp = cell(nOrgan,1);
for i=1:nOrgan
    rvMC = zeros(1,nIon);
    rvSC = zeros(1,nIon);
    
    for k=1:nIon
        [rvMC(k),rvSC(k)] = subStaticsDeOutlier(msiDataOrgan_Ctr{i}(:,k),dbZscoreOutlier);
    end
    lsEntSpect_Ctr{i} = (msiDataOrgan_Ctr{i} - ones(numPixel_Ctr(i),1) * rvMC)./(ones(numPixel_Ctr(i),1) * rvSC); % zscore
    lsEntSpect_Exp{i} = (msiDataOrgan_Exp{i} - ones(numPixel_Exp(i),1) * rvMC)./(ones(numPixel_Exp(i),1) * rvSC); % zscore
    
    lsEntSpect_Ctr{i} = discretize(lsEntSpect_Ctr{i},nBin); % 加这一句，保证拟合概率密度函数时，用的间隔一样。可比性比较强。
    lsEntSpect_Exp{i} = discretize(lsEntSpect_Exp{i},nBin); % 加这一句，保证拟合概率密度函数时，用的间隔一样。可比性比较强。
end

for i=1:nOrgan
    matTem = lsEntSpect_Ctr{i};
    cvMI = zeros(numPixel_Ctr(i),1);
    for k=1:numPixel_Ctr(i)
        rvProb = Probability(matTem(k,:),nBin,nIon);
        rvProb(rvProb<=0)=[];
        rvProb = rvProb/sum(rvProb);
        cvMI(k)= -1 * sum(rvProb .* log2(rvProb));
    end
    lsEntSpect_Ctr{i} = cvMI;
    
    matTem = lsEntSpect_Exp{i};
    cvMI = zeros(numPixel_Exp(i),1);
    for k=1:numPixel_Exp(i)
        rvProb = Probability(matTem(k,:),nBin,nIon);
        rvProb(rvProb<=0)=[];
        rvProb = rvProb/sum(rvProb);
        cvMI(k)= -1 * sum(rvProb .* log2(rvProb));
    end
    lsEntSpect_Exp{i} = cvMI;
end

clear nBin dbZscoreOutlier nOrgan nIon rvMC rvSC matTem cvMI i k;
end


function rvProb = Probability(cvScore,nBin,nLen)
tem = histogram(cvScore,1:nBin);
rvProb = tem.Values/nLen;
clear tem;
end