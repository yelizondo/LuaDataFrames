-- Some lua utilities

-- Def: Prints a Lua Table
-- Ret: nil
function printTable(table)
	local result = ""
	for i=1,#table do
		result = result .. " " .. table[i]
	end
	print(result)
end

-- Def: Prints an error 
-- Ret: nil
function THROW_ERROR(errorName)
	print("ERROR: ", errorName)
	return nil
end