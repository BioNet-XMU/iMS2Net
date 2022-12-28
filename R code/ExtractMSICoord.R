ExtractMSICoord <- function(pathSource_Ctr,pathCoord_Ctr){
  tiny_in <- readMSIData(pathSource_Ctr, attach.only=TRUE)
  dir.create(pathCoord_Ctr)
  filename = paste0(pathCoord_Ctr,"CoordX")
  write.table(tiny_in@elementMetadata@coord@listData[["x"]],filename, row.names=FALSE, col.names=FALSE, sep=",")
  filename = paste0(pathCoord_Ctr,"CoordY")
  write.table(tiny_in@elementMetadata@coord@listData[["y"]],filename, row.names=FALSE, col.names=FALSE, sep=",")
}
