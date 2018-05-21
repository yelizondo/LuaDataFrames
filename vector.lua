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

   		-- Indexing function: c{}[index]
   		-- It index with both positive and negative 
   		-- numbers, boolean tables, index tables
   		-- and strings
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

		-- Function for the + operator
		-- It can add single integers
		-- or tables, if different size, reuses elements
		__add = function(table,o)
			local new = c{}

			if (type(o) == "number") then
				for i=1,#_table do
					new[i] = _table[i] + o
				end
			elseif (type(o) == "table") then
				local smallest = nil
				local biggest = nil
				
				if (#_table >= #o) then
					biggest = _table
					smallest = o
				else
					smallest = _table
					biggest = o
				end

				for i=1, #biggest do
					new = new .. (biggest[i]+smallest[calcIndex(i,#smallest)])
				end
			end
			return new
		end,

		__sub = function(table,o)
			local new = c{}

			-- Single number
			if (type(o) == "number") then
				for i=1,#_table do
					new[i] = _table[i] - o
				end

			-- Table
			elseif (type(o) == "table") then 
				local firstOp = tableToVector(_table)
				local secondOp = o

				-- Same length, no reusing
				if (#o == #_table) then 
					for i=1, #firstOp do
						new = new .. (firstOp[i] - secondOp[i])
					end

				-- Different length, reusing
				else 
					local biggest = nil

					if (#firstOp >= #secondOp) then 
						biggest = #firstOp
					else
						biggest = #secondOp
					end 

					for i=1, biggest do
						if (#firstOp >= #secondOp) then 
							new = new .. (firstOp[i]-secondOp[calcIndex(i,#secondOp)])
						else
							new = new .. (firstOp[calcIndex(i,#firstOp)]-secondOp[i])
						end
					end
				end
			end
			return new
		end,

		__mul = function(table, o)
			local new = c{}

			if (type(o) == "number") then
				for i=1,#_table do
					new[i] = _table[i] * o
				end
			elseif (type(o) == "table") then
				local smallest = nil
				local biggest = nil
				
				if (#_table >= #o) then
					biggest = _table
					smallest = o
				else
					smallest = _table
					biggest = o
				end

				for i=1, #biggest do
					new = new .. (biggest[i]*smallest[calcIndex(i,#smallest)])
				end
			end
			return new
		end,

		__div = function(table,o)
			local new = c{}

			-- Single number
			if (type(o) == "number") then
				for i=1,#_table do
					new[i] = _table[i] / o
				end

			-- Table
			elseif (type(o) == "table") then 
				local firstOp = tableToVector(_table)
				local secondOp = o

				-- Same length, no reusing
				if (#o == #_table) then 
					for i=1, #firstOp do
						new = new .. (firstOp[i] / secondOp[i])
					end

				-- Different length, reusing
				else 
					local biggest = nil

					if (#firstOp >= #secondOp) then 
						biggest = #firstOp
					else
						biggest = #secondOp
					end 

					for i=1, biggest do
						if (#firstOp >= #secondOp) then 
							new = new .. (firstOp[i]/secondOp[calcIndex(i,#secondOp)])
						else
							new = new .. (firstOp[calcIndex(i,#firstOp)]/secondOp[i])
						end
					end
				end
			end
			return new
		end,

		__unm = function(table)
			local new = c{}

			for i=1, #_table do 
				new = new .. - _table[i]
			end
			return new
		end,

	--=====================================================
		-- Comparison Operators
		-- Lua only allows to work with two vectors
		-- Para las funciones de comparacion
		-- lua no deja retornar un table, como se hace en R
		-- Implementacion queda pendiente
		__eq = function(table,o)
		end,

		__lt = function(table,v)
		end,

		__le = function(table,v)
		end,
	--=====================================================

		__concat = function(table,v)
			local new = c{}
			if (type(v) ~= "table") then
				for i=1, #_table do
					new[i] = _table[i]
				end
				new[#_table+1] = v
			else 
				for i=1,#_table do
					new[i] = _table[i]
				end

				local j = 1
				for i = #_table+1, #_table + #v do
					new[i] = v[j]
					j = j + 1
				end
			end
			return new
		end,

		__tostring = function(table) 
			local result = ""
			for i = 1,#_table do 
				if (_table[i] ~= nil) then 
					if (_table[i] ~= true and _table[i] ~= false) then 
						result = result  .. _table[i] .. "\t"
					else
						if (_table[i]) then
							result = result  .. "true" .. "\t"
						else
							result = result  .. "false" .. "\t"
						end
					end
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

function length(vector)
	return #vector
end


-- Calculates the index to use
-- when reusing elements
function calcIndex(index,lim)
	if (index <= lim) then
		return index
	else 
		if (index%lim ~= 0) then
			return (index%lim) 
		else
			return (index%lim) + 3
		end
	end
end

function tableToVector(table)
	local new = c{}

	for i=1, #table do
		new = new .. table[i]
	end

	return new
end

function vector(args)
	args.mode = args.mode or "any"
	args.length = args.length or 0

	local new = c{}
	if (args.length == 0) then 
			return new
	else
		if (args.mode == "logical") then  
			for i=1, args.length do
				new = new .. false
			end
		elseif (args.mode == "numeric" or args.mode == "double") then
			for i=1, args.length do
				new = new .. 0
			end
		elseif (args.mode == "character") then
			for i=1, args.length do
				new = new .. ''
			end
		elseif (args.mode == "raw") then
			for i=1, args.length do
				new[i] = nil
			end
		elseif (args.mode == "any") then
			for i=1, args.length do 
				new[i] = nil
			end 
		end
	end

	return new
end