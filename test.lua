require "matrix"
require "vector"

local a = matrix{data=c{2,4,3,1,5,7},nrow=2,ncol=3,byrow=true}
local b = a[2][3]
print(b)