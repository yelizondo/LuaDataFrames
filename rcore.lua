-- Some necessary code to mimic R

NA = -9999991

is = {}
at = {}

function is_empty(arg)
	if (type(arg.x) == "table") then
		if (#arg.x == 0) then
			return true 
		end
		return false
	end
end