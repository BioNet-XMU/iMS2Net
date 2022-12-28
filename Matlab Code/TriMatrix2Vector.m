function cvData = TriMatrix2Vector(matData,iDiagonal,isUpper)
%
% 用matlab 自带函数   squareform(D,'tovector'); 但是，squareform
% 是按行串起来的。TriMatrix2Vector 是按列串起来的
%

if ~exist('isUpper','var'),isUpper = 1;end
if ~exist('iDiagonal','var'),iDiagonal =1;end  % iDiagonal=0 包括对角线，iDiagonal=1 从第一条对角线开始

if isUpper==1
    cvData = matData(logical(triu(ones(size(matData)),iDiagonal))); % 取上三角的元素集合
else
    cvData = matData(logical(trid(ones(size(matData)),iDiagonal))); % 取上三角的元素集合
end