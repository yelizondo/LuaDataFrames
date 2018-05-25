require "vector"
require "rcore"

-- Main function
matrix = function (arg)

	-- Initialization
	arg = argumentRevision(arg)

	local newMatrix = buildMatrix(arg)
	
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
	elseif (arg.nrow == true and arg.ncol == false) then
		arg.ncol = #arg.data / nrow
	elseif (arg.nrow == false and arg.ncol == true)  
		arg.nrow = #arg.data / ncol
	end 
	
	-- To do at the ending
	arg.dimnames = arg.dimnames

	-- First got to find out what this
	arg.x = arg.x

	return arg
end

function is.matrix()
end
function at.matrix()
end


-- Pending revision
function buildMatrix(table)
	
end