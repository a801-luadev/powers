eventMouse = function(playerName, x, y)
	local time, cache = playerCanTriggerEvent(playerName)
	if not time then return end

	local playerX, playerY = room.playerList[playerName]
	playerX, playerY = playerX.x, playerX.y

	local power = Power.__mouse[cache.mouseSkill]
	if cache.powers[power.name]
		-- Not internal, must be explicit
		and (power.clickRange == 0 or pythagoras(playerX, playerY, x, y, power.clickRange)) then

		power:trigger(playerName, cache, time, playerX, playerY, nil, x, y)
	end
end