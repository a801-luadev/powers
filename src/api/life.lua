local addHealth = function(playerName, cache, hp)
	hp = hp or 0
	if cache.extraHealth > 0 then
		hp = hp + cache.extraHealth
		cache.extraHealth = 0
	end
	cache.health = cache.health + hp
	if cache.health > 100 then
		cache.health = 100
	end

	updateLifeBar(playerName, cache.health)
end

local damagePlayer = function(playerName, damage, _cache)
	_cache = _cache or playerCache[playerName]
	_cache.health = _cache.health - damage

	if _cache.health <= 0 then
		_cache.health = 0
		killPlayer(playerName)
		return true
	else
		updateLifeBar(playerName, _cache.health)
		return false
	end
end

local damagePlayersWithAction = function(except, damage, action, filter, x, y, ...)
	local hasKilled = false
	for name, cache in next, getPlayersOnFilter(except, filter, x, y, ...) do
		if (not action and true or action(name))
			and damagePlayer(name, damage, cache) then -- Has died
			hasKilled = true
			playerData:set(except, "kills", 1, true)
		end
	end
	if hasKilled then
		playerData:save(except)
	end
end

local damagePlayers = function(except, damage, filter, x, y, ...)
	return damagePlayersWithAction(except, damage, nil, filter, x, y, ...)
end