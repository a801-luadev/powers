eventNewPlayer = function(playerName)
	if not playerCache[playerName] then
		playerCache[playerName] = {
			health = 0,
			isFacingRight = true,
			powers = { },
			extraHealth = 0,
			powerCooldown = 0,
			soulMate = nil,
			keySequence = KeySequence.new(),
			totalInterfaceTextareas = 0,
			totalInterfaceImages = 0,
			interfaceImages = { }
		}
	end

	players_insert("room", playerName)
	players_insert("dead", playerName)

	lowerSyncDelay(playerName)

	for _, power in next, powers do
		if power.bind then
			power:bindControl(playerName)
		end
	end

	loadPlayerData(playerName)

	-- Displayed once because the image is never removed
	displayLifeBar(playerName)
end