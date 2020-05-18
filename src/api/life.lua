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