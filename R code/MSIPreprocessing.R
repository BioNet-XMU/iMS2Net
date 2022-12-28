MSIPreprocessing <- function(pathSource_Ctr,type='profile'){
  
  if((type !='profile')&(type!='centroid')){
    stop("TypeError:type only has two options 'profile' or 'centroid'")
  }
  
  data <- import(pathSource_Ctr, type='imzML')
  
  if(type!='centroid'){
    # Spectral alignment
    data = alignSpectra(data) 
    # Peak picking
    data = detectPeaks(data, halfWindowSize=5, method=c("MAD"), SNR=2) 
  }
 
  # Peak alignment
  data = binPeaks(data, method='strict', tolerance = 0.005)
  return(data)
}


 