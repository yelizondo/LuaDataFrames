require "vector"

matrix = {}

matrix = function (arg)
	local table = arg
	local _table = table

	table = {}
	local metatable = {
		__index = function()
		end,
		__tostring = function()
		end
	}


	setmetatable(table, metatable)
	return table
end