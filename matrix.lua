require "vector"
require "rcore"

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

	-- First got to find out what this
	arg.x = arg.x

	return arg
end

function is_matrix()
end
function at_matrix()
end


-- Pending revision
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

	for i=1,cols do
		local elements = c{}
		for j=1,rows do
			elements = elements .. arg.data[cols*rows]
		end
		result = result .. elements
	end

	return result
end