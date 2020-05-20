local str_getBytes = function(str)
	local len = #str
	if len > 8000 then -- avoids 'string slice too long'
		local out = { }
		for i = 1, len do
			out[i] = byte(str, i, i)
		end
		return out
	else
		return { byte(str, 1, -1) }
	end
end

local str_split = function(str, pattern, raw, f)
	local out, counter = { }, 0

	local strPos = 1
	local i, j
	while true do
		i, j = find(str, pattern, strPos, raw)
		if not i then break end
		counter = counter + 1
		out[counter] = sub(str, strPos, i - 1)
		out[counter] = (f and f(out[counter]) or out[counter])

		strPos = j + 1
	end
	counter = counter + 1
	out[counter] = sub(str, strPos)
	out[counter] = (f and f(out[counter]) or out[counter])

	return out, counter
end