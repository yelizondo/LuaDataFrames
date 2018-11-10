-- Def: Reads all the contents from a file
-- Ret: string
function readAllFile(pFilePath)
	local MODE = "*all"
	local file = assert(io.open(pFilePath, "rb"))
	local content = file:read(MODE)
	file:close()
	return content
end

-- Def: Writes a file
-- Ret: void
function writeFile(pFilePath, pContent, mode)
	local file = io.open(pFilePath, mode)
	file:write(pContent)
	file:close()
end

-- Def: Reads a csv file
-- Ret: table
function readCSV(pFilePath, pDelimiter)

end

-- This method uses ftcsv to read CVS files
-- Returns a DataFrame
function readCSVaux(path,sep)
	dataFrame = {}

	-- Lib to read csv
	local ftcsv = require('ftcsv')

	-- data
	local data, headers = ftcsv.parse(path,sep)

	for i = 1, #data do
		prev = {}
		for j = 1, #headers do
			prev[j] = data[i][headers[j]]
		end
		dataFrame[i] = prev
	end

	-- set the headers
	for i = #dataFrame, 1, -1 do
		dataFrame[i+1] = dataFrame[i] 
	end
	dataFrame[1] = headers

	return dataFrame
end