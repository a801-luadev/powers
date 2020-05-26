eventNewPlayer = function(playerName)
	if not playerCache[playerName] then
		playerCache[playerName] = {
			level = 1,
			roundLevel = nil, -- Level on round start
			levelColor = nil,

			health = 0,
			extraHealth = 0, -- Health points that were accumulated and will be updated together

			isFacingRight = true,

			powers = { }, -- All individual powers' data
			powerCooldown = 0,
			keySequence = KeySequence.new(),

			soulMate = nil,

			totalInterfaceTextareas = 0,
			totalInterfaceImages = 0,
			interfaceImages = { },

			hasOpenInterface = false,

			menuIndex = 1,
			lastMenuIndex = nil,
			menuContentId = nil,
			menuTabId = nil,

			powerInfoIdSelected = nil,
			powerInfoImageId = nil
		}
	end

	players_insert("lobby", playerName)

	if not isValidPlayer(playerName) then return end

	lowerSyncDelay(playerName)

	for _, power in next, powers do
		if power.bindControl then
			power:bindControl(playerName)
		end
	end

	loadPlayerData(playerName)

	-- Displayed once because the image is never removed
	displayLifeBar(playerName)
end