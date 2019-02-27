-- Some lua utilities

-- Def: Prints a Lua Table
-- Ret: nil
function printTable(table)
	local result = ""
	for i=1, #table do
		local content = table[i] or "nil"
		result = result .. " " .. content
	end
        print(result)
end

-- Def: Prints an error 
-- Ret: nil
function THROW_ERROR(errorName)
	print("ERROR: ", errorName)
	return nil
end

-- Def: Split a string
-- Ret: table
function splitString(inputstr, sep, spaces)
    spaces = spaces or false
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        if (spaces) then
            str = removeSpaces(str)
        end
        t[i] = str
        i = i + 1
    end
    return t
end

function removeSpaces(inputstr)
        return string.gsub(inputstr, "%s+", "")
end
function removeAllQuotres(inputstr)
	return string.gsub(inputstr,'"','')
end
function isStrNumber(string)
	return tonumber(string) ~= nil
end

-- Multiple argument processing
function getMulArgs(...)
    arg = {...}
    if type(arg[1]) == "table" then
        arg = arg[1]
        end
    return arg
end

