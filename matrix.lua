require "vector"
require "rcore"

-- Main function
matrix = function (arg)
	-- Initialization
	if (is_empty{x=arg.data}) then
		THROW_ERROR("Data vector expected but arg.data is empty")
		return nil
	end

	arg.nrow
	arg.ncol
	arg.byrow
	arg.dimnames
	arg.x
	
end

function is.matrix()
end
function at.matrix()
end


-- Pending revision
function buildMatrix(table)
	local data = table[1]
	if (#data == 0 or data == "nil") then 
		return THROW_ERROR("data must be of a vector type, was nil. Execution halted") 
	end
	local nrow = table.nrow
	local ncol = table.ncol
	local byrow = table.byrow
	local names = table.dimnames
	local sparse = table.sparse
	local doDiag = table.doDiag
	local forceCheck = table.forceCheck



end