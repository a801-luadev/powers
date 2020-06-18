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

local table_copy = function(list)
	local out = { }
	for k, v in next, list do
		out[k] = v
	end
	return out
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
		out[tbl[i]] = i
	end
	return out
end