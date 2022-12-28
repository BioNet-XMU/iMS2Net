function [matEntIon_Ctr, matEntIon_Exp] = Entropy_Ion(msiDataOrgan_Ctr, msiDataOrgan_Exp,numPixel_Ctr,numPixel_Exp)

nBin = 100; % 运行时间 14�?
dbZscoreOutlier = 3.0;

nOrgan = length(msiDataOrgan_Ctr);
nIon = size(msiDataOrgan_Ctr{1},2);

arrEntIon_Ctr = cell(nOrgan,1);
arrEntIon_Exp = cell(nOrgan,1);
for i=1:nOrgan
    rvMC = zeros(1,nIon);
    rvSC = zeros(1,nIon);
    for k=1:nIon
        [rvMC(k),rvSC(k)] = subStaticsDeOutlier(msiDataOrgan_Ctr{i}(:,k),dbZscoreOutlier);
    end
    arrEntIon_Ctr{i} = (msiDataOrgan_Ctr{i} - ones(numPixel_Ctr(i),1)*rvMC)./(ones(numPixel_Ctr(i),1)*rvSC);
    arrEntIon_Exp{i} = (msiDataOrgan_Exp{i} - ones(numPixel_Exp(i),1)*rvMC)./(ones(numPixel_Exp(i),1)*rvSC);
    
    arrEntIon_Ctr{i} = discretize(arrEntIon_Ctr{i},nBin);
    arrEntIon_Exp{i} = discretize(arrEntIon_Exp{i},nBin);
end

matEntIon_Ctr = zeros(nOrgan,nIon);
matEntIon_Exp = zeros(nOrgan,nIon);
for i =1:nOrgan
    for k=1:nIon
        rvProb = Probability(arrEntIon_Ctr{i}(:,k),nBin,numPixel_Ctr(i));
        rvProb(rvProb==0)=[];
        
        cvTemMI = -1 * rvProb .* log2(rvProb);
        matEntIon_Ctr(i,k) = sum(cvTemMI);
        
        rvProb = Probability(arrEntIon_Ctr{i}(:,k),nBin,numPixel_Exp(i));
        rvProb(rvProb==0)=[];
        
        cvTemMI = -1 * rvProb .* log2(rvProb);
        matEntIon_Exp(i,k) = sum(cvTemMI);
    end
end
clear arrEntIon_Ctr arrEntIon_Exp nOrgan nIon rvMC rvSC i k nBin dbZscoreOutlier rvProb cvTemMI;
end

function rvProb = Probability(cvScore,nBin,nLen)
tem = histogram(cvScore,1:nBin);
rvProb = tem.Values/nLen;
clear tem;
end