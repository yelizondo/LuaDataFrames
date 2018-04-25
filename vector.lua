
c = {}

c = function(arg)
  	local table = arg
  	local _table = table
   
   	table = {}
   	local metatable = {

		__index = function (table, key)
			return _table[key]
		end,

		__newindex = function (table, key, value)
			_table[key] = value
		end,

		__add = function(table,o)
			local new = c{}
			for i = 1, #_table do 
				new[i]= _table[i] + o 
			end
			return new
		end,

		__sub = function(table,o)
			local new = c{}
			for i = 1, #_table do 
				new[i]= _table[i] - o 
			end
			return new
		end,

		__mul = function(table, o)
			local new = c{}
			for i = 1, #_table do 
				new[i]= _table[i] * o 
			end
			return new
		end,

		__div = function(table,o)
		end,

		__mod = function(table,o)
		end,

		__unm = function(table)
		end,

		__eq = function(table,v)
		end,

		__lt = function(table,v)
		end,

		__le = function(table,v)
		end,

		__tostring = function(table)
			local result = ""

			for i = 1,#_table do
				result = result  .. _table[i] .. "\t"
			end

			return result
		end,

		__len = function(table)
			return #_table
		end

	}
	setmetatable(table, metatable)
	return table
end