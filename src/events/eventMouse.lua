eventMouse = function(playerName, x, y)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local playerX, playerY = tfm.get.room.playerList[playerName]
	playerX, playerY = playerX.x, playerX.y

	local playerPowers = cache.powers

	local src = Power.__mouse
	for power = 1, Power.__eventCount.__mouse do
		power = src[power]

		-- Not internal, must be explicit
		if playerPowers[power.name] and pythagoras(playerX, playerY, x, y, power.clickRange)
			and power:trigger(playerName, cache, time, x, y) then
			return
		end
	end
end