
c = {}

c = function(arg)
  	local t = arg
  	local _t = t
   
   	t = {}
   	local mt = {

		__index = function (t,k)
			return _t[k]
		end,

		__newindex = function (t,k,v)
			_t[k] = v
		end,

		__add = function(t,o)
		end,

		__sub = function(t,o)
		end,

		__mul = function(t,o)
			local new = c{}
			for i = 1, #_t do 
				new[i]= _t[i]*o 
			end
			return new
		end,

		__div = function(t,o)
		end,

		__mod = function(t,o)
		end,

		__unm = function(t)
		end,

		__eq = function(t,v)
		end,

		__lt = function(t,v)
		end,

		__le = function(t,v)
		end,

		__tostring = function(t)
		end
	
	}
	setmetatable(t, mt)
	return t
end

  local x = c{10,20,30,40}
  local y = x * 2
  print(y[1],y[2],y[3])
  local z = y * 10
print(z[1],z[2],z[3])

