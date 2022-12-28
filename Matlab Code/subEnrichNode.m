function [cvLinkNumb,cvLinkWeighted,nSample] = subEnrichNode(cellSSN,cvLinkProb,dbMinRatio)
%
% 功能：将 cvLinkProb 作为网络边的差异概率，就算各单样本网络的显著边数目
%       以及加权显著边的数目
%
if ~exist('dbMinRatio','var'),dbMinRatio=0.2;end

cvLinkMask = (cvLinkProb >= dbMinRatio);
nSample   = length(cellSSN);
cvLinkNumb = zeros(nSample,1);
cvLinkWeighted = zeros(nSample,1);
for i=1:nSample
   cvLinkNumb(i) = sum(cellSSN{i}.cvSigLink .* cvLinkMask);
   cvLinkWeighted(i) = sum(cellSSN{i}.cvSigLink .* cvLinkMask .* cvLinkProb);
end
clear cvLinkMask i;
