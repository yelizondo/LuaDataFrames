function readAllFile(pFilePath)
	local MODE = "*all"
	local file = assert(io.open(pFilePath, "rb"))
	local content = file:read(MODE)
	file:close()
	return content
end

function writeFile(pFilePath, pContent, mode)
	local file = io.open(pFilePath, mode)
	file:write(pContent)
	file:close()
end