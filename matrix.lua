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
	local indexes = ""
	for i=1,#matrix[1] do
		indexes = indexes .. "\t" .. i .. "."
	end

	print(indexes)

	for i=1, #matrix do
		print(i..".",matrix[i])
	end
	print()
end

-- On development
function is.matrix()
end

function at.matrix()
end

-- Transpose a matrix
function t(matrix)
	local result = c{}
	for i=1,#matrix[1] do
		result[i] = c{}
	end

	for i=1, #matrix do
		for j=1,#matrix[i] do
			result[j][i] = matrix[i][j]
		end
	end
	return result
end

-- Combining matrices
function cbind(m1,m2)
	if (#m1 == #m2) then
		for i=1,#m1 do
			m1[i] = m1[i] .. m2[i]
		end

		return m1
	else
		return THROW_ERROR("Argument matrices for cbing must have the same amount of rows")
	end
end

function rbind(m1,m2)
	if (#m1[1] == #m2[1]) then
		
		for i=1,#m2 do
			m1[#m1+1] =  m2[i]
		end

		return m1
	else
		return THROW_ERROR("Argument matrices for cbing must have the same amount of columns")
	end
end

-- Deconstruct mustn't bell called c(), 'cause will cause conflict 
function deconstruc(matrix)
	local result = c{}

	for i=1,#matrix do
		for j=1, matrix[i] do
			result = result .. matrix[i][j]
		end
	end

	return result
end