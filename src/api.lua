local players = {
	room  = { },
	alive = { },
	dead  = { },
	_count = {
		room = 0,
		alive = 0,
		dead = 0
	}
}

local players_insert = function(where, playerName)
	if not players[where][playerName] then
		players._count[where] = players._count[where] + 1
		players[where][playerName] = playerName
	end
end

local players_remove = function(where, playerName)
	if players[where][playerName] then
		players._count[where] = players._count[where] - 1
		players[where][playerName] = nil
	end
end

-------------------------------------------------

local table_copy = function(list)
	local out = { }
	for k, v in next, list do
		out[k] = v
	end
	return out
end

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

local table_random = function(tbl)
	return tbl[random(#tbl)]
end

-------------------------------------------------

do
	local link = linkMice
	linkMice = function(p1, p2, linked)
		if linked then
			playerCache[p1].soulMate = p2
			playerCache[p2].soulMate = p1
		else
			playerCache[p1].soulMate = nil
			playerCache[p2].soulMate = nil
		end

		return link(p1, p2, linked)
	end
end

-------------------------------------------------

local inRectangle = function(x, y, rx, ry, rw, rh, rightDirection)
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

-------------------------------------------------

local playerCanTriggerEvent = function(playerName)
	local data = tfm.get.room.playerList[playerName]

	return canTriggerPowers and not data.isDead
end

-------------------------------------------------

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

	if _cache.health <= 0 then
		killPlayer(playerName)
		removeLifeBar(playerName)
	else
		updateLifeBar(playerName, _cache.health)
	end
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

local addHealth = function(playerName, cache, hp)
	hp = hp or 0
	if cache.extraHealth > 0 then
		hp = hp + cache.extraHealth
		cache.extraHealth = 0
	end
	cache.health = cache.health + hp

	updateLifeBar(playerName, cache.health)
end
