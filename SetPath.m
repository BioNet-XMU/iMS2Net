function SetPath()

 restoredefaultpath; % �ָ�ȱʡ�� Path
 
 str=cd;
 myAddPath(str);

 disp('Set Path Success!');
end

function myAddPath(strPath)
strAllPath=genpath(strPath);
rvPos=find(strAllPath==';');
nDir=length(rvPos);
rvPos=[0,rvPos];

for i=1:nDir,
    addpath(strAllPath(rvPos(i)+1:rvPos(i+1)-1));
end
end