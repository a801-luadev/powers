eventMouse = function(playerName, x, y)
	if not playerCanTriggerEvent(playerName) then return end

	local time = time()
	local cache = playerCache[playerName]

	local playerX, playerY = tfm.get.room.playerList[playerName]
	playerX, playerY = playerX.x, playerX.y

	local src = Power.__mouse
	for power = 1, Power.__eventCount.__mouse do
		power = src[power]

		-- Not internal, must be explicit
		if pythagoras(playerX, playerY, x, y, power.clickRange)
			and power:trigger(playerName, cache, time, x, y) then
			return
		end
	end
end