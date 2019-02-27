require "vector"
require "utils"

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

-- Def: Reads a csv line
-- Ret: table
function parseCSVLine(line, sep) 
	local res = {}
	local pos = 1
	sep = sep or ','
	while true do 
		local c = string.sub(line,pos,pos)
		if (c == "") then break end
		if (c == '"') then
			-- quoted value (ignore separator within)
			local txt = ""
			repeat
				local startp,endp = string.find(line,'^%b""',pos)
				txt = txt..string.sub(line,startp+1,endp-1)
				pos = endp + 1
				c = string.sub(line,pos,pos) 
				if (c == '"') then txt = txt..'"' end 
				-- check first char AFTER quoted string, if it is another
				-- quoted string without separator, then append it
				-- this is the way to "escape" the quote char in a quote. example:
				--   value1,"blub""blip""boing",value3  will result in blub"blip"boing  for the middle
			until (c ~= '"')
			table.insert(res,txt)
			assert(c == sep or c == "")
			pos = pos + 1
		else	
			-- no quotes used, just look for the first separator
			local startp,endp = string.find(line,sep,pos)
			if (startp) then 
				table.insert(res,string.sub(line,pos,startp-1))
				pos = endp + 1
			else
				-- no separator found -> use rest of string and terminate
				table.insert(res,string.sub(line,pos))
				break
			end 
		end
	end
	return res
end

-- Def: Reads a csv file
-- Ret: table ;  i=1 -> headers ; i[][1] = names
function readCSVtoTable(pFilePath, pDelimiter)
	local data = {}

	-- Read the file
	local file = readAllFile(pFilePath)
	local csvLines = splitString(file,"\n")

	-- Read the headers
	local headers = parseCSVLine(table.remove(csvLines,1),pDelimiter)

	-- Set the headers
	data[1] = headers

	-- Set the remaining data
	for i=1, #csvLines do
		local contentTable = parseCSVLine(csvLines[i], pDelimiter)
		table.insert(data, contentTable)
	end

	data[1] = headers

	return data
end

-- Def: read a csv file to a DataFrame
-- Ret: DataFrame
function readCSVToDF(pFilePath, pDelimiter)
	local data = c{}

	-- Read the file
	local file = readAllFile(pFilePath)
	local csvLines = splitString(file,"\n")

	-- Read the headers
	local headers = parseCSVLine(table.remove(csvLines,1),pDelimiter)

	-- Set the headers
	data[1] = c(headers)

	-- Set the remaining data
	for i=1, #csvLines do
		local contentTable = parseCSVLine(csvLines[i], pDelimiter)
		data[i+1] = c(contentTable)
	end

	data[1] = c(headers)

	return data
end

-- Def: read a csv file 
-- Ret: Depends on the returnType set by the user, default is dataFrame
function readCSV(pFilePath, pDelimiter, pReturnType)
	pReturnType = pReturnType or "df"
	local result = nil

	if (pReturnType == "df") then
		result = readCSVToDF(pFilePath, pDelimiter)
	elseif (pReturnType == "t") then
		result = readCSVtoTable(pFilePath, pDelimiter)
	else
		THROW_ERROR("Return type not supported, use \"df\" for data frame or \"t\" for table")
	end

	return result
end