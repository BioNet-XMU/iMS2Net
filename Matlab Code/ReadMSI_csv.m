function[lsMZ, msiData_Ctr, msiData_Exp, imgSize_Ctr, imgSize_Exp] = ReadMSI_csv(pathProc_Ctr, pathProc_Exp, pathCoord_Ctr, pathCoord_Exp, mzInterval)

paths = {pathProc_Ctr,pathProc_Exp};
x_paths = {strcat(pathCoord_Ctr,'CoordX'),strcat(pathCoord_Exp,'CoordX')};
y_paths = {strcat(pathCoord_Ctr,'CoordY'),strcat(pathCoord_Exp,'CoordY')};
for i=1:2
    p = paths{i};
    f1 = x_paths{i};
    f2 = y_paths{i};
    if ~exist(p,'dir')
        error(strcat('FolderNotFound:',p));
    end
    if ~exist(f1,'file')
        error(strcat('FileNotFound:',f1));
    end
    if ~exist(f2,'file')
        error(strcat('FileNotFound:',f2));
    end
end

%common peak-------------------------------------
all_peaks = {};
temp = {};
ind = 0;
for i=1:length(paths)
    path = paths{i};
    filelist = dir(path);
    f_n = length(filelist); %file_num
    pixel_n = f_n-2 ;   %pixel_num
    slide_peaks = {};
    for j=3:pixel_n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        f = filelist(j).name;
        r_pixelf = [path,f];  %read_pixel_file
        peak = csvread(r_pixelf,1,0);
        
        slide_peaks{end+1}=peak;  
        temp{end+1} = peak(:,1)';
    end
    all_peaks{end+1} = slide_peaks;
end

p_max = max(cell2mat(temp));
p_min = min(cell2mat(temp));

lsMZ = p_min:mzInterval:p_max;
nPeak=length(lsMZ);
nPeak = int16(nPeak);
%data_mat
data_fillMat = {};
coord = {};
for i = 1:2
    s_peaks = all_peaks{1,i};
    data_mat = zeros(length(s_peaks),nPeak);
    
    for j = 1:length(s_peaks)
        peaks = s_peaks{j};
        mz = peaks(:,1);
        intensity = peaks(:,2);
        bin = zeros(1,nPeak);
        
        for k=1:(nPeak-1)
            index = (mz>=lsMZ(k))&(mz<lsMZ(k+1));
            bin(1,k) = sum(intensity(index));
        end
        index = mz>=lsMZ(nPeak);
        bin(1,nPeak) = sum(intensity(index));
        data_mat(j,:) = bin;
    end 
    %fill 0,colum
    x_p = x_paths{1,i};
    y_p = y_paths{1,i};
    xs = load(x_p);
    ys = load(y_p);
    
    x_m = max(xs);
    y_m = max(ys);
    coord{i}=[x_m,y_m];
    
    data_fill = zeros(x_m*y_m,nPeak);
    for n=1:length(s_peaks)
        x=xs(n);
        y=ys(n);
        data_fill((x-1)*y_m+y,:) = data_mat(n,:);%colum (y-1)*x_m+x
    end
    size(data_fill);
    data_fillMat{i} = data_fill;
end

msiData_Ctr = data_fillMat{1};
msiData_Exp = data_fillMat{2};

imgSize_Ctr = coord{1};
imgSize_Exp = coord{2};