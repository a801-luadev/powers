local table_copy = function(list)
	local out = { }
	for k, v in next, list do
		out[k] = v
	end
	return out
end

local players = {
	room  = { _count = 0 },
	alive = { _count = 0 },
	dead  = { _count = 0 }
}

local players_insert = function(where, playerName)
	if not where[playerName] then
		where._count = where._count + 1
		where[where._count] = playerName
		where[playerName] = where._count
	end
end

local players_remove = function(where, playerName)
	if where[playerName] then
		where._count = where._count - 1
		where[where[playerName]] = nil
		where[playerName] = nil
	end
end