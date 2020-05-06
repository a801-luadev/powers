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

local inRectangle = function(x, y, rx, rw, ry, rh, rightDirection)
	return (rightDirection
		and (x >= rx and x <= (rx + rw))
		or (x >= (rx - rw) and x <= rx)
	) and (y >= ry and y <= (ry + rh))
end

local pythagoras = function(x, y, cx, cy, cr)
	x = x - cx
	x = x * x
	y = y - cy
	y = y * y
	cr = cr * cr
	return x + y < cr
end

local getPlayersOnFilter = function(except, filter, ...)
	local data = { }

	local player
	for playerName in next, players.alive do
		if playerName ~= except then
			player = tfm.get.room.playerList[playerName]
			if filter(player.x, player.y, ...) then
				data[playerName] = playerCache[playerName]
			end
		end
	end

	return data
end

local damage = function(playerName, damage, _cache)
	_cache = _cache or playerCache[playerName]
	_cache.health = _cache.health - damage
end

local damagePlayers = function(except, damage, filter, x, y, ...)
	for name, cache in next, getPlayersOnFilter(except, filter, x, y, ...) do
		damage(name, damage, cache)
	end
end

local damagePlayersWithAction = function(except, damage, action, filter, x, y, ...)
	for name, cache in next, getPlayersOnFilter(except, filter, x, y, ...) do
		if action(name) then
			damage(name, damage, cache)
		end
	end
end