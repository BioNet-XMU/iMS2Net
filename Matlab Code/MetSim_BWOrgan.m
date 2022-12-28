function matSim = MetSim_BWOrgan(msiDataOrgan)

nOrgan = length(msiDataOrgan);
cvNode = zeros(nOrgan,1);
for i=1:nOrgan
    cvNode(i) = size(msiDataOrgan,1);
end

matSim = zeros(nOrgan,nOrgan);
for iLabel=1:nOrgan
    cellDist = subNumLinkSSN(msiDataOrgan,nOrgan,iLabel);
    for i=1:nOrgan
        matSim(iLabel,i) = median(cellDist{i});
    end
end
% matSim(1,:) =[7, 1, 6, 2,3.5, 3.5,  5];
% matSim(2,:) =[2, 7, 3.5, 1, 6, 5, 3.5];
% matSim(3,:) =[6, 1.5, 7, 1.5, 3.5, 3.5, 5];
% matSim(4,:) =[1, 2.5, 2.5, 7, 6, 4, 5];
% matSim(5,:) =[2.5, 2.5, 2.5, 2.5, 7, 5.5, 5.5];
% matSim(6,:) =[2.5, 2.5, 2.5, 2.5, 5.5, 7, 5.5];
% matSim(7,:) =[4.5, 1, 4.5, 2, 4.5, 4.5, 7];
matSim = 0.5*(matSim+matSim');

clear nOrgan cvNode cellDist iLabel i;