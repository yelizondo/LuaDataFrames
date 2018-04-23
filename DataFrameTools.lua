-- This is a Data Frame Tools library for Lua, 
-- with the R syntax as a base
-- Developed by Yuberth ELizondo Cordero

-- This method uses ftcsv to read CVS files
-- Returns a DataFrame
function readCSV(path,sep)
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

-- Prints a Lua Table
function printTable(table)
	local result = ""
	for i=1,#table do
		result = result .. " " .. table[i]
	end
	print(result)
end

-- Prints a Data Frame
function printDataFrame(table)
	for i = 1, #table do
		printTable(table[i])
	end
end

-- Prints the head of a data frame, row or column, default is 6 rows
function head(dataFrame, rows)
	rows = rows or 6
	if (type(dataFrame[1]) == "table") then
		for i = 1, rows+1 do -- +1 to include headers
			printTable(dataFrame[i])
		end
	else 
		print("En desarrollo")
	end
end

-- Prints the tail of a data frame, row or column, default is 6 rows
function tail(dataFrame, rows)
	rows = rows or 6

	-- Headers
	printTable(dataFrame[1]) 

	for i = rows-1, 0, -1 do
		printTable(dataFrame[#dataFrame-i]) 
	end
end

-- Prints all the row names
function rownames(dataFrame)
	result = {}
	for i = 2, #dataFrame do
		result[i-1] =  "\'"..dataFrame[i][1].."\'"
	end
	printTable(result)
end

-- Returns the number of rows
function nrow(dataFrame)

	return #dataFrame-1
end

-- Returns the number of columns
function ncol(dataFrame)

	return #dataFrame[1]-1
end

-- Return a table with all the elements of the row
-- row can be int or string
function getRow(dataFrame, row)
	local rows = nrow(dataFrame)
	local temp = {}

	if (type(row) == 'number') then
		if (row > 0 and row <= rows) then
			temp = dataFrame[row+1]
		else 
			print("Range exeeded")
			return
		end
	elseif (type(row) == 'string') then
		local _row = getRowIndex(dataFrame,row)
		if (_row ~= -9999) then
			temp = dataFrame[_row]
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
function getCol(dataFrame, col)
	local result = {}
	local cols = ncol(dataFrame)

	if (type(col) == 'number') then
		if (col > 0 and col <= cols) then
			for i=2,#dataFrame do
				table.insert(result, dataFrame[i][col+1])
			end
		else 
			print("Range exeeded")
			return
		end
	elseif (type(col) == 'string') then
		local _col = getColIndex(dataFrame,col)
		if (_col ~= -9999) then
			for i=2,#dataFrame do
				table.insert(result, dataFrame[i][_col])
			end	
		else
			print("Name not found") 
			return 
		end
	end
	return result
end

-- Given the name of a Row, it returns its index
function getRowIndex(dataFrame, row)
	for i = 1, #dataFrame do
		if (dataFrame[i][1] == row) then
			return i
		end
	end
	return -9999
end

-- Given the name of a Column, it returns its index
function getColIndex(dataFrame, col)
	for i=1, #dataFrame[1] do
		if (dataFrame[1][i] == col) then 
			return i
		end
	end
	return -9999
end

-- A cell can be accessed by the row and column with 
-- indexes or names - they can be a combination
function getCell(dataFrame, row, col)
	if (type(row) == 'number' and type(col) == 'number') then
		local rows = nrow(dataFrame)
		local cols = ncol(dataFrame)

		if ((row > 0 and row <= rows) and (col > 0 and col <= cols)) then
			return dataFrame[row+1][col+1]
		else
			print("Range exeeded")
			return
		end
	elseif (type(row) == 'string' and type(col) == 'string') then 
		local _row = getRowIndex(dataFrame,row)
		local _col = getColIndex(dataFrame,col)
		if (_row ~= -9999 or _col ~= -9999) then
			return dataFrame[_row][_col]
		else
			print("Names not found") 
			return 
		end
	elseif (type(row) == 'string' and type(col) == 'number') then
		local _row = getRowIndex(dataFrame,row)
		if ((col > 0 and col <= ncol(dataFrame)) and _row ~= -9999) then
			return dataFrame[_row][col+1]
		else
			print("Names not found") 
			return
		end
	elseif (type(row) == 'number' and type(col) == 'string') then 
		local _col = getColIndex(dataFrame,col) 
		if ((row > 0 and row <= nrow(dataFrame)) and _col ~= -9999) then
			return dataFrame[row+1][_col]
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



