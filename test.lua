require "DataFrameTools"
require "vector"

-- Testing area

local dataFrame = readCSV("mtcars.csv", ",")

-- Need this working 
--printTable(getCol(dataFrame,"hp"))

local var = c{1,2,3,4}