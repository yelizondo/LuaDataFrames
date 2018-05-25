function is_empty(arg)
	

	if (type(arg) == "table") then
		if (#arg == 0) then
			return true 
		end
		return false
	end
end

-- Prints an error and returns nil
function THROW_ERROR(errorName)
	print(errorName)
	return 
end