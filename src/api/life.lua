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

	updateLifeBar(playerName, cache)
end

local givePlayerKill = function(killerName, killedName, killerCache)
	playerData
		:set(killerName, "kills", 1, true)
		:set(killerName, "xp", module.xp_on_kill, true)

	local msg = format(getText.kill, playerCache[killerName].chatNickname, killerCache.chatNickname)
	chatMessage(msg, killerName)
	chatMessage(msg, killedName)
end

local damagePlayer = function(playerName, damage, cache, _attackerName, _time)
	cache.health = cache.health - damage

	if cache.health <= 0 then
		cache.lastDamageBy = nil
		cache.health = 0
		killPlayer(playerName)
		return true
	else
		if _attackerName then -- If player falls or something, the kill is given to the last damage
			cache.lastDamageBy = _attackerName
			cache.lastDamageTime = _time
		end
		updateLifeBar(playerName, cache)
		return false
	end
end

local damagePlayersWithAction = function(except, damage, action, filter, x, y, ...)
	local time = time() + 3000

	local hasKilled = false
	for name, cache in next, getPlayersOnFilter(except, filter, x, y, ...) do
		if (not action and true or action(name))
			and damagePlayer(name, damage, cache, except, time) then -- Has died
			hasKilled = true
			givePlayerKill(except, name, cache)
		end
	end
	if hasKilled then
		playerData:save(except)
	end
end

local damagePlayers = function(except, damage, filter, x, y, ...)
	return damagePlayersWithAction(except, damage, nil, filter, x, y, ...)
end