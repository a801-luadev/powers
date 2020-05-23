eventNewGame = function()
	ignoreRoundData = false

	nextMapLoadTentatives = 0
	setNextMapIndex()

	-- Resets players
	players.lobby = { }
	players._count.lobby = 0

	players.dead = { }
	players._count.dead = 0
	players.alive = table_copy(players.room)
	players._count.alive = players._count.room

	canTriggerPowers = false
	timer.start(enablePowersTrigger, 3000, 1)

	-- Resets powers
	for name, obj in next, powers do
		if obj.type == powerType.divine then
			obj:reset()
		end
	end

	-- Resets players
	local currentTime, cache = time()
	for playerName in next, players.alive do
		cache = playerCache[playerName]
		if not cache.hasPlayerData then
			killPlayer(playerName)
		else
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
	end

	hasTriggeredRoundEnd = false

	canSaveData = (isOfficialRoom and tfm.get.room.uniquePlayers >= module.min_players)
	-- Adds extra XP
	if canSaveData then
		timer.start(giveExperience, module.extra_xp_in_round_seconds, 1)
	end
end
