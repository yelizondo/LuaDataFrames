
-- Prints an error and returns nil
function THROW_ERROR(errorName)
	print(errorName)
	return
end

-- Checks if all the elements of a table are within a range
function elementsInRange(table,min,max)
	for i=1,#table do
		if (not(table[i] >= min and table[i] <= max)) then 
			return false
		end
	end
	return true
end

c = {}

c = function(arg)
  	local table = arg
  	local _table = table

    table = {}

    -- Allows to check if all the elements are booleans
    table.allBoolean = function()
    	for i=1,#table do
    		if (type(table[i]) ~= "boolean") then
    			return false
    		end
    	end
    	return true
    end
	-- Allows to check if all the elements are strings
    table.allString = function()
    	for i=1,#table do
    		if (type(table[i]) ~= "string") then
    			return false
    		end
    	end
    	return true
    end
	-- Allows to check if all the elements are ints
    table.allInt = function()
    	for i=1,#table do
    		if (type(table[i]) ~= "number") then
    			return false
    		end
    	end
    	return true
    end

   	local metatable = {

		__index = function (table, key)

			if (type(key) == "number") then
				if (math.abs(key) > 0 and math.abs(key) <= #table) then
					if (key > 0) then 
						return _table[key]
					else
						local new = c{}
						local i = 1
						local j = 1

						while (i <= #_table) do 
							if (math.abs(key) == i) then 
								i = i + 1
							end
							new[j] = _table[i]
							i = i + 1
							j = j + 1
						end
						return new
					end
				else
					THROW_ERROR("NA")
					return
				end
			elseif (type(key) == "table") then 
				if (key.allBoolean()) then 
					if (#table == #key) then
						local new = c{}
						for i=1,#key do
							if (key[i]) then 
								new = new .. table[i]
							end
						end 
						return new
					else
						THROW_ERROR("Tables must have the same length")
						return
					end

				elseif (key.allInt()) then
					if (elementsInRange(key,1,#table)) then
						local new = c{}
						for i=1,#key do
							new = new .. table[key[i]]
						end
						return new
					else
						THROW_ERROR("To index with a table, index must be between ".. 1 .. " and ".. #table..".")
						return
					end
				elseif (key.allString()) then

				else
					THROW_ERROR("Table not valid for indexing")
					return
				end
			else -- Can't index with the above
				THROW_ERROR("Unable to index with \"" .. key .. "\"")
				return
			end 
		end,

		__newindex = function (table, key, value)
			_table[key] = value
		end,

		__add = function(table,o)
			local new = c{}
			for i = 1, #_table do 
				new[i]= _table[i] + o 
			end
			return new
		end,

		__sub = function(table,o)
			local new = c{}
			for i = 1, #_table do 
				new[i]= _table[i] - o 
			end
			return new
		end,

		__mul = function(table, o)
			local new = c{}
			for i = 1, #_table do 
				new[i]= _table[i] * o 
			end
			return new
		end,

		__div = function(table,o)
		end,

		__mod = function(table,o)
		end,

		__unm = function(table)
		end,

		__eq = function(table,v)
		end,

		__lt = function(table,v)
		end,

		__le = function(table,v)
		end,

		__concat = function(table,v)

			if (type(v) ~= "table") then 
				table[#table+1] = v
			else 
				local j = 1
				for i= #table+1, #table + #v do
					table[i] = v[j]
					j = j + 1
				end
			end
			return table
		end,

		__tostring = function(table)
			local result = ""

			for i = 1,#_table do
				if (_table[i] ~= nil) then
					result = result  .. _table[i] .. "\t"
				else
					result = result  .. "nil" .. "\t"
				end
			end

			return result
		end,

		__len = function(table)
			return #_table
		end
	}

	setmetatable(table, metatable)
	return table
end

function vector()
	
end
