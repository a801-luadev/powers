local players = {
	room = { },
	alive = { },
	dead = { },
	lobby = { },
	_count = {
		room = 0,
		alive = 0,
		dead = 0,
		lobby = 0
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

local players_remove_all = function(playerName)
	for k, v in next, players do
		if k ~= "_count" then
			players_remove(k, playerName)
		end
	end
end

local isValidPlayer = function(playerName)
	playerName = tfm.get.room.playerList[playerName]
	return playerName.id > 0 -- Is not souris
		--sub(playerName, 1, 1) ~= "*"
		and (time() - playerName.registrationDate)
			>= (5 * 60 * 60 * 24 * 1000) -- Is a player for longer than 5 days
end

local playerCanTriggerEvent = function(playerName, cache)
	cache = cache or playerCache[playerName]

	local time = time()
	if cache.powerCooldown > time then return end

	if canTriggerPowers and not (tfm.get.room.playerList[playerName].isDead
		or cache.isInterfaceOpen) then
		return time, cache
	end
end

local playerCanTriggerCallback = function(playerName, cache)
	cache = cache or playerCache[playerName]

	local time = time()
	if cache.interfaceActionCooldown > time then return end
	cache.interfaceActionCooldown = time + 1000

	return cache
end

local giveExperience = function()
	for playerName in next, players.alive do
		playerData:set(playerName, "xp", module.extra_xp_in_round, true)
	end
end

local setPlayerLevel = function(playerName, cache)
	local level, remainingXp, needingXp = xpToLvl(playerData:get(playerName, "xp"))
	cache.level = level
	cache.currentLevelXp = remainingXp
	cache.nextLevelXp = needingXp

	if level == cache.roundLevel then return end

	local levelIndex = level - level%10
	local levelColor = levelColors[levelIndex]
	if not levelColor then
		levelIndex = module.max_player_level - module.max_player_level%10
		levelColor = levelColors[levelIndex]
	end

	cache.levelIndex = levelIndex
	cache.levelColor = levelColor

	return level
end

local checkPlayerLevel = function(playerName, cache)
	if not canSaveData then return end

	local newLevel = setPlayerLevel(playerName, cache)
	if not newLevel then return end

	chatMessage(format(getText.newLevel, prettifyNickname(playerName, 10, nil, "/B><G", 'B'),
		newLevel))

	-- Checks unlocked powers
	local powerNames = getText.powers
	local nameByLevel = Power.__nameByLevel

	local levelNames, counter, storedNames = { }, 0
	for lvl = cache.roundLevel, newLevel do -- Checks all new levels, it can be more than one.
		storedNames = nameByLevel[lvl]
		if storedNames then
			for i = 1, #storedNames do
				counter = counter + 1
				levelNames[counter] = powerNames[storedNames[i]]
			end
		end
	end

	if counter > 0 then
		chatMessage(format(getText.unlockPower, "<B>" .. table_concat(levelNames, "</B>, <B>") ..
			"</B>"), playerName)
	end
end