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

local inRectangle = function(x, y, x1, x2, y1, y2)
	return (x >= x1 and x <= x2) and (y >= y1 and y <= y2)
end

local getPlayersOnFilter = function(except, filter, ...)
	local data = { }

	local player
	for playerName in next, players.alive do
		if playerName ~= except then
			player = tfm.get.room.playerList[playerName]
			if filter(player.x, player.y, ...) then
				data[playerName] = player
			end
		end
	end

	return data
end