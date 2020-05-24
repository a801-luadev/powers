eventNewGame = function()
	-- Resets players
	players.dead = { }
	players._count.dead = 0
	players.alive = table_copy(players.room)
	players._count.alive = players._count.room

	nextMapLoadTentatives = 0
	hasTriggeredRoundEnd = false

	if isLobby then
		setGameTime(5)
		addTextArea(textAreaId.lobby, "<font size='40'><p align='center'>" .. getText.minPlayers,
			nil, 5, 45, 790, nil, 1, 1, 0, true)
		return
	end
	wasLobby = false

	ignoreRoundData = false
	setNextMapIndex()

	timer.start(enablePowersTrigger, 3000, 1)

	-- Resets powers
	for name, obj in next, powers do
		if obj.type == powerType.divine then
			obj:reset()
		end
	end

	-- Resets players
	for playerName in next, players.lobby do
		killPlayer(playerName)
	end

	local currentTime, cache = time()
	for playerName in next, players.alive do
		cache = playerCache[playerName]
		cache.health = 100
		cache.isFacingRight = not tfm.get.room.mirroredMap
		cache.extraHealth = 0
		cache.powerCooldown = 0
		cache.soulMate = nil
		cache.roundLevel = cache.level

		updateLifeBar(playerName, cache)

		cache = cache.powers
		for name, obj in next, powers do
			-- Resets individual powers settings
			cache[name] = obj:getNewPlayerData(currentTime)
		end
	end

	canSaveData = (isOfficialRoom and tfm.get.room.uniquePlayers >= module.min_players)
	-- Adds extra XP
	if canSaveData then
		timer.start(giveExperience, module.extra_xp_in_round_seconds, 1)
	end
end
