-- This is a Data Frame Tools library for Lua, 
-- with the R syntax as a base
-- Developed by Yuberth ELizondo Cordero

require "fileio"
require "utils"
require "vector"

DataFrame = {}

DataFrame = function(arg)
  	
  	local _df = arg
    local df = {}

	local metatable = {
		__index = function (df, key)
			local result = nil
			local iar = indexingArgumentProcessing(key)

			if (iar.type == "number") then
				result = getRow(_df, iar.value)
			elseif (iar.type == "string") then
				result = getRow(_df, iar.value)
			elseif (iar.type == "end_nil_string_pair" or iar.type == "end_nil_number_pair") then 
				print(iar.value)
				result = getRow(_df, iar.value)
			elseif (iar.type == "start_nil_string_pair" or iar.type == "start_nil_number_pair") then
				result = getCol(_df, iar.value)
			elseif (iar.type == "printAll") then
				result = _df
			else
				result = getCell(_df, iar.value[1], iar.value[2])
			end

			return result
		end,

		__newindex = function (df, key, value)
		end,

		__tostring = function(df)
		end
	}
	
	setmetatable(df, metatable)
	return df
end

-- get multiple arguments values
function a(arg1, arg2)
    local args = {}

    if (arg1 ~= nil and arg2 ~= nil) then 
    	if (typeCheck(arg1) and typeCheck(arg2)) then 
	    	args["NumArgs"] = 2
	    	args["Arg1"] = arg1
	    	args["Arg2"] = arg2
	    else
	    	THROW_ERROR("Argument type not supported for indexing")
    	end
    elseif (arg1 == nil and arg2 ~= nil) then
    	if (typeCheck(arg2)) then 
	    	args["NumArgs"] = 1
	    	args["Arg1"] = nil 
	    	args["Arg2"] = arg2
	    else
	    	THROW_ERROR("Argument type not supported for indexing")
	    end
    elseif (arg1 ~= nil and arg2 == nil) then 
    	if (typeCheck(arg1)) then 
	    	args["NumArgs"] = 1
	    	args["Arg1"] = arg1 
	    	args["Arg2"] = nil
	    else
	    	THROW_ERROR("Argument type not supported for indexing")
	    end
    else
    	args["NumArgs"] = 0
    end 

    return args
end

--number
--string with commas
--string without commas

function typeCheck(pArgument)
	local supportedIndexTypes = {"number","string"}

	for i=1, #supportedIndexTypes do
		if (type(pArgument) == supportedIndexTypes[i]) then 
			return true
		end
	end
	return false
end



-- Prints the head of a data frame, row or column, default is 6 rows
function head(DataFrame, rows)
	rows = rows or 6
	if (type(DataFrame[1]) == "table") then
		for i = 1, rows+1 do -- +1 to include headers
			printTable(DataFrame[i])
		end
	else 
		print("En desarrollo")
	end
end

-- Prints the tail of a data frame, row or column, default is 6 rows
function tail(DataFrame, rows)
	rows = rows or 6

	-- Headers
	printTable(DataFrame[1]) 

	for i = rows-1, 0, -1 do
		printTable(DataFrame[#DataFrame-i]) 
	end
end

-- Prints all the row names
function rownames(DataFrame)
	result = {}
	for i = 2, #DataFrame do
		result[i-1] =  "\'"..DataFrame[i][1].."\'"
	end
	printTable(result)
end

-- Returns the number of rows
function nrow(DataFrame)

	return #DataFrame-1
end

-- Returns the number of columns
function ncol(DataFrame)

	return #DataFrame[1]-1
end

-- Return a table with all the elements of the row
-- row can be int or string
function getRow(DataFrame, row)
	local rows = nrow(DataFrame)
	local temp = {}

	if (type(row) == 'number') then
		if (row > 0 and row <= rows) then
			temp = DataFrame[row+1]
		else 
			print("Range exeeded")
			return
		end
	elseif (type(row) == 'string') then
		local _row = getRowIndex(DataFrame,row)
		if (_row ~= -9999) then
			temp = DataFrame[_row]
		else
			print("Name not found") 
			return 
		end
	end

	local result = {}

	for i=2,#temp do
		table.insert(result, temp[i])
	end

	return result
end

-- Return a table with all the elements of the column
-- col can be int or string
function getCol(DataFrame, col)
	local result = {}
	local cols = ncol(DataFrame)

	if (type(col) == 'number') then
		if (col > 0 and col <= cols) then
			for i=2,#DataFrame do
				table.insert(result, DataFrame[i][col+1])
			end
		else 
			print("Range exeeded")
			return
		end
	elseif (type(col) == 'string') then
		local _col = getColIndex(DataFrame,col)
		if (_col ~= -9999) then
			for i=2,#DataFrame do
				table.insert(result, DataFrame[i][_col])
			end	
		else
			print("Name not found") 
			return 
		end
	end
	return result
end

-- Given the name of a Row, it returns its index
function getRowIndex(DataFrame, row)
	for i = 1, #DataFrame do
		if (DataFrame[i][1] == row) then
			return i
		end
	end
	return -9999
end

-- Given the name of a Column, it returns its index
function getColIndex(DataFrame, col)
	for i=1, #DataFrame[1] do
		if (DataFrame[1][i] == col) then 
			return i
		end
	end
	return -9999
end

-- A cell can be accessed by the row and column with 
-- indexes or names - they can be a combination
function getCell(DataFrame, row, col)
	if (type(row) == 'number' and type(col) == 'number') then
		local rows = nrow(DataFrame)
		local cols = ncol(DataFrame)

		if ((row > 0 and row <= rows) and (col > 0 and col <= cols)) then
			return DataFrame[row+1][col+1]
		else
			print("Range exeeded")
			return
		end
	elseif (type(row) == 'string' and type(col) == 'string') then 
		local _row = getRowIndex(DataFrame,row)
		local _col = getColIndex(DataFrame,col)
		if (_row ~= -9999 or _col ~= -9999) then
			return DataFrame[_row][_col]
		else
			print("Names not found") 
			return 
		end
	elseif (type(row) == 'string' and type(col) == 'number') then
		local _row = getRowIndex(DataFrame,row)
		if ((col > 0 and col <= ncol(DataFrame)) and _row ~= -9999) then
			return DataFrame[_row][col+1]
		else
			print("Names not found") 
			return
		end
	elseif (type(row) == 'number' and type(col) == 'string') then 
		local _col = getColIndex(DataFrame,col) 
		if ((row > 0 and row <= nrow(DataFrame)) and _col ~= -9999) then
			return DataFrame[row+1][_col]
		else
			print("Names not found") 
			return
		end
	end
end

-- Returns the max of a table
function max(table)

	return math.max(unpack(table))
end

-- Returns the min of a table
function min(table)
	
	return math.min(unpack(table))
end

-- Returns the sum of all the elements in a table
function sum(table)
	local result = 0
	for i=1,#table do
		result = result + table[i]
	end
	return result
end

-- Return the average of a table
function mean(table)

	return sum(table) / #table
end



