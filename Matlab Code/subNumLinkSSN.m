function cellDist = subNumLinkSSN(msiDataOrgan,nOrgan,iLabel)
 
dbMinRatio = 0.2; % 计算比例，只有大于 dbMinRatio 的边才认为是差异边.0.2 比较合适
dbPValue   = 0.01;

cellDist = cell(nOrgan,1);
for i = 1:nOrgan
    if i==iLabel
        [cellSSN,cvLinkRatio] = SSN_PCC_Ref(msiDataOrgan{iLabel},dbPValue);
    else
        [cellSSN,cvLinkRatio] = SSN_PCC(msiDataOrgan{iLabel},msiDataOrgan{i},dbPValue);
    end    
    cellDist{i} = subEnrichNode(cellSSN,cvLinkRatio,dbMinRatio);
end