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

local givePlayerKill = function(killerName, killedName, killedCache)
	local playerData = playerData.playerData[killerName]
	playerData.kills = playerData.kills + 1
	playerData.xp = playerData.xp + module.xp_on_kill

	local cache = playerCache[killerName]
	if playerData.kills == 666 then
		giveBadge(killerName, "killer", cache)
	end

	cache.roundKills = cache.roundKills + 1

	if cache.spawnHearts then
		local killedData = room.playerList[killedName]
		addBonus(0, killedData.x, killedData.y,
			addImage(interfaceImages.heartToken, imageTargets.tokenIcon, killedData.x - 15,
				killedData.y - 15, killerName), 0, false, killerName)
	end

	local msg = format(getText.kill, cache.chatNickname, killedCache.chatNickname)
	chatMessage(msg, killerName)
	chatMessage(msg, killedName)
end

local damagePlayer = function(playerName, damage, cache, _attackerName, _time)
	cache.health = cache.health - (damage * cache.hpRate)

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