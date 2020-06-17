eventEmotePlayed = function(playerName, id)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local playerX, playerY = tfm.get.room.playerList[playerName]
	playerX, playerY = playerX.x, playerX.y

	local playerPowers = cache.powers

	local src = Power.__emotePlayed
	for power = 1, Power.__eventCount.__emotePlayed do
		power = src[power]

		-- Not internal, must be explicit
		if playerPowers[power.name] and id == power.triggererEmote
			and power:checkTriggerPossibility()
			and power:trigger(playerName, cache, time, playerX, playerY) then
			return
		end
	end
end