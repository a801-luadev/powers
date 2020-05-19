eventNewPlayer = function(playerName)
	if not playerCache[playerName] then
		playerCache[playerName] = {
			hasPlayerData = false,

			health = 0,
			extraHealth = 0,

			isFacingRight = true,

			powers = { },
			powerCooldown = 0,
			keySequence = KeySequence.new(),

			soulMate = nil,

			totalInterfaceTextareas = 0,
			totalInterfaceImages = 0,
			interfaceImages = { },

			menuIndex = 1,
			lastMenuIndex = nil,
			menuContentId = nil,
			menuTabId = nil
		}
	end

	players_insert("lobby", playerName)
	players_insert("room", playerName)

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