require "DataFrameTools"

-- Testing area

local dataFrame = readCSV("mtcars.csv", ",")

-- Need this working 
head(getCol(dataFrame,"hp"))