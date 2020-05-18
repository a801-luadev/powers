local table_add
table_add = function(src, tbl, deep)
	for k, v in next, tbl do
		if deep and type(v) == "table" then
			src[k] = { }
			table_add(src[k], v, deep)
		else
			src[k] = v
		end
	end
end

local table_addArray = function(src, add)
	local len = #src
	for i = 1, #add do
		src[len + i] = add[i]
	end
end

local table_arrayRange = function(arr, i, j)
	i = i or 1
	j = j or #arr
	if i > j then return { } end

	local newArray, counter = { }, 0
	for v = i, j do
		counter = counter + 1
		newArray[counter] = arr[v]
	end
	return newArray
end

local table_copy = function(list)
	local out = { }
	for k, v in next, list do
		out[k] = v
	end
	return out
end

local table_mapArray = function(arr, f)
	local newArray = { }
	for i = 1, #arr do
		newArray[i] = f(arr[i])
	end
	return newArray
end

local table_random = function(tbl)
	return tbl[random(#tbl)]
end

local table_shuffle = function(tbl)
	local rand
	for i = #tbl, 1, -1 do
		rand = random(i)
		tbl[i], tbl[rand] = tbl[rand], tbl[i]
	end
end

local table_set = function(tbl)
	local out = { }
	for i = 1, #tbl do
		out[tbl[i]] = true
	end
	return out
end

local table_writeBytes = function(bytes)
	return table_concat(table_mapArray(bytes, char))
end