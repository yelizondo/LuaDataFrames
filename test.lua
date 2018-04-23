require "DataFrameTools"

-- Testing area

local dataFrame = readCSV("mtcars.csv", ",")

-- Need this working 
printTable(getCol(dataFrame,"hp"))