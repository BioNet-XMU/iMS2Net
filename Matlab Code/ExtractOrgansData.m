function [msiDataOrgan,numPixel] = ExtractOrgansData(msiData,lblPixel)

cvLabel = lblPixel(:);

if length(cvLabel) ~= size(msiData,1)
    error('Image sizes doesnot match!');
end

nOrgan = max(cvLabel);
numPixel = zeros(nOrgan,1);
msiDataOrgan = cell(nOrgan,1);
for j=1:nOrgan
	msiDataOrgan{j} = msiData(cvLabel==j,:);
    numPixel(j) = sum(cvLabel==j);
end

clear cvLabel nOrgan j;