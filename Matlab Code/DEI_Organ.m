function matCoDEI = DEI_Organ(msiDataOrgan_Exp, msiDataOrgan_Ctr)

dbZscoreOutlier = 3;
dbMinES = 1.96;     % 1.96, 0.975; 1.645, 0.95

nOrgan = length(msiDataOrgan_Exp);
nIon = size(msiDataOrgan_Exp{1},2);

rvES = zeros(1,nIon);   % Effect Size
rvMC = zeros(1,nIon);rvME = zeros(1,nIon);
rvSC = zeros(1,nIon);rvSE = zeros(1,nIon);

matCoDEI = zeros(nOrgan,nIon);
for i=1:nOrgan    
    for k=1:nIon
        [rvMC(k),rvSC(k),~,nSampleC] = subStaticsDeOutlier(msiDataOrgan_Ctr{i}(:,k),dbZscoreOutlier);
        [rvME(k),rvSE(k),~,nSampleE] = subStaticsDeOutlier(msiDataOrgan_Exp{i}(:,k),dbZscoreOutlier);

        rvES(k) = (1-3/(4*nSampleE + 4*nSampleC - 9))*abs(rvMC(k)-rvME(k))*sqrt(nSampleC+nSampleE-2)/sqrt((nSampleC-1)*rvSC(k)*rvSC(k)+(nSampleE-1)*rvSE(k)*rvSE(k)); % 计算 Effect Size
    end

    % Effect Size
    matCoDEI(i,:) = (rvES >= dbMinES).* sign(rvME-rvMC);% 符号
end
clear dbZscoreOutlier dbMinES rvES matES rvMC rvME rvSC rvSE i k nOrgan nIon;