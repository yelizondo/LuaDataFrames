require "fileIO"
require "stack"

R_INTERNALS_PATH = "RDataInternals.json"

function getLinesFromString(pFile)
	if pFile:sub(-1) ~= "\n" then 
		pFile = pFile .. "\n" 
	end
    return pFile:gmatch("(.-)\n")
end

function getFileLines(pFile)
	local result = {}

	for line in getLinesFromString(pFile) do
		if (#line >= 1) then
			table.insert(result,line)
		end
	end
	return result
end

-- Has termporary hardcoded values for testing,
-- they will eventually be loaded with a json
function loadRInternals(pPath) 
	local result = {
		["LISTSXP"] = "1026",
		["SYMSXP"] = "1",
		["CHARSXP"] = "262153",
		["INTSXP"] = "13",
		["NILVALUESXP"] = "254"
}
	return result
end

function getElements(pFileLines,rInternals)
	local result = {}
	-- Remove unnecessary lines
	for i = 1, 7 do 
		table.remove(pFileLines,1)
	end

	table.remove(pFileLines,#pFileLines)

	local tempElem = {}

	for i=1, #pFileLines do 
		if (pFileLines[i] == rInternals["CHARSXP"] or 
			pFileLines[i] == rInternals["LISTSXP"] or 
			pFileLines[i] == rInternals["NILVALUESXP"]) then 
			if (tempElem ~= nil and #tempElem > 0) then 
				table.insert(result,tempElem)
			end
			tempElem = {}
		else 
			table.insert(tempElem,pFileLines[i])
		end
	end
	return result
end

function evaluateRInternals(pFileLines)
	-- Result
	local result = {}

	-- Read R internals from disk       
	local rInternals = loadRInternals(R_INTERNALS_PATH)

	local elements = getElements(pFileLines,rInternals)
	
	for i=1,#elements do
		print(unpack(elements[i]))
	end

	return result

end

function load(pFile)
	-- Read the file from disk 
	local file = readAllFile(pFile)       
	-- Load the data to a table         
	local fileLines = getFileLines(file)    

	local table = evaluateRInternals(fileLines)
end

function save()
end

