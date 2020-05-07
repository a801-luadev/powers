do
	local enablePowersTriggers = function()
		canTriggerPowers = true
	end

	eventNewGame = function()
		players.dead = { _count = 0 }
		players.alive = table_copy(players.room)

		hasRefreshedTimers = false
		canTriggerPowers = false

		timer.start(enablePowersTriggers, 3000, 1)

		for name, obj in next, powers do
			if obj.type == powerType.divine then
				obj:reset()
			end
		end

		local currentTime = os.time()
		for playerName in next, players.alive do
			playerName = playerCache[playerName]
			playerName.health = 100
			playerName.isFacingRight = true
			playerName.extraHealth = 0

			playerName = playerName.powers
			for name, obj in next, powers do
				playerName[name] = obj:getNewPlayerData(currentTime)
			end
		end
	end
end