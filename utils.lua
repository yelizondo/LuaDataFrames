-- Some lua utilities

-- Def: Prints a Lua Table
-- Ret: nil
function printTable(table)
	local result = ""
	for i=1,#table do
		local content = table[i] or "nil"
		result = result .. " " .. content
	end
	print(result .. "\n")
end

-- Def: Prints an error 
-- Ret: nil
function THROW_ERROR(errorName)
	print("ERROR: ", errorName)
	return nil
end

-- Def: Split a string
-- Ret: table
function splitString(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end