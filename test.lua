require "fileio"
require "utils"
require "dataframe"

local df = readCSV("mtcars.csv",",")

for i=1,#df do
	printTable(df[i])
end