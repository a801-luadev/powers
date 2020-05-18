local str_split = function(str, pattern, raw)
	local out, counter = { }, 0

	local strPos = 1
	local i, j
	while true do
		i, j = find(str, pattern, strPos, raw)
		if not i then break end
		counter = counter + 1
		out[counter] = sub(str, strPos, i - 1)

		strPos = j + 1
	end
	counter = counter + 1
	out[counter] = sub(str, strPos)

	return out, counter
end