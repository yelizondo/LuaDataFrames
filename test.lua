--require "matrix"
--require "vector"
--local a = matrix{data=c{0,0,0,0,0,0},nrow=3,ncol=2,byrow=true}
--local b = matrix{data=c{1,1,1,1,1,1},nrow=3,ncol=2,byrow=true}
--printMatrix(a)
--printMatrix(b)
--a = rbind(a,b)
--printMatrix(a)

require "/rdatareading/RDataIO"
load("/home/yuberth/Projects/LuaDataFrames/rdatareading/testingFiles/integer.d")


