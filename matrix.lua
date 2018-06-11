require "vector"
require "rcore"

-- Indexing is made with vector indexing, no need to implement

-- Main function
matrix = function (arg)

	-- Initialization
	arg = argumentRevision(arg)

	local newMatrix = buildMatrix(arg)

	return newMatrix	
end

function argumentRevision(arg)
	
	if (is_empty{x=arg.data}) then
		THROW_ERROR("Data vector expected but arg.data is empty")
		return nil
	end

	arg.byrow = arg.byrow or false

	if (arg.nrow == nil and arg.ncol == nil) then
		arg.nrow = 1
		arg.ncol = 1 
	elseif (arg.nrow ~= nil and arg.ncol == nil) then
		arg.ncol = #arg.data / arg.nrow 
	elseif (arg.nrow == nil and arg.ncol ~= nil)   then
		arg.nrow = #arg.data / arg.ncol
	end 

	-- To do at the ending
	arg.dimnames = arg.dimnames

	-- First got to find out what this is
	arg.x = arg.x

	return arg
end

function is_matrix()
end

function at_matrix()
end

function buildMatrix(arg)
	local cols
	local rows
	local result = c{}

	if (arg.byrow) then
		rows = arg.nrow
		cols = arg.ncol
	else 
		cols = arg.nrow
		rows = arg.ncol
	end

	-- Initialize the matrix
	for i=1,rows do
		result[i] = c{}
	end

	-- Fill the matrix
	for i=0, rows-1 do
		for j=1, cols do
			result[i+1][j] = arg.data[i*cols+j]
		end
	end

	return result
end

function printMatrix(matrix)
	local indexes = "\t"
	for i=1,#matrix[1] do
		indexes = indexes .. "\t" .. i
	end

	print(indexes)
	print("")

	for i=1, #matrix do
		print(i.."\t",matrix[i])
	end

end