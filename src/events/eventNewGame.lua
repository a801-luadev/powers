eventNewGame = function()
	canLoadNextMap, nextMapLoadTentatives = false, 0
	setNextMapIndex()

	players.dead = { }
	players._count.dead = 0
	players.alive = table_copy(players.room)
	totalPlayersInRound = players._count.room
	players._count.alive = totalPlayersInRound

	canTriggerPowers = false
	timer.start(enablePowersTrigger, 3000, 1)

	for name, obj in next, powers do
		if obj.type == powerType.divine then
			obj:reset()
		end
	end

	local currentTime = time()
	for playerName in next, players.alive do
		playerName = playerCache[playerName]
		if not playerName.hasPlayerData then
			killPlayer(playerName)
		else
			playerName.health = 100
			playerName.isFacingRight = not tfm.get.room.mirroredMap
			playerName.extraHealth = 0
			playerName.powerCooldown = 0
			playerName.soulMate = nil

			playerName = playerName.powers
			for name, obj in next, powers do
				playerName[name] = obj:getNewPlayerData(currentTime)
			end
		end
	end

	updateLifeBar(nil, 100)

	hasTriggeredRoundEnd = false

	canSaveData = (isOfficialRoom and totalPlayersInRound >= module.min_players)
	if canSaveData then
		timer.start(giveExperience, module.extra_xp_in_round_seconds, 1)
	end
end
