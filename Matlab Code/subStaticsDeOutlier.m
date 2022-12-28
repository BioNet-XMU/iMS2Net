function [dbMean,dbStd,dbMedian,nSample] = subStaticsDeOutlier(cvData,dbOutlierZscore)
%
% 功能：获取没有 outlier 的统计量
%
bCont = 1;
nSample = length(cvData);
cvHit = true(nSample,1);
while(bCont==1)
    cvZ = zscore(cvData(cvHit));
    cvH = (abs(cvZ)>dbOutlierZscore);
    if sum(cvH)>0
        cvHit(cvHit==1)= (1-cvH);
    else
        bCont = 0;
    end
end

dbMean= mean(cvData(cvHit==1));
dbStd= std(cvData(cvHit==1));
dbMedian = median(cvData(cvHit==1));

clear cvHit bCont;
end