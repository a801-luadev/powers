eventNewPlayer = function(playerName)
	if not playerCache[playerName] then
		playerCache[playerName] = {
			-- Level and XP
			level = 1,
			currentLevelXp = nil,
			nextLevelXp = nil,
			roundLevel = nil, -- Level on round start
			levelIndex = nil, -- ex: 10, 20, 30
			levelColor = nil,

			-- Round life
			health = 0,
			extraHealth = 0, -- Health points that were accumulated and will be updated together

			-- Round powers
			powers = { }, -- All individual powers' data
			powerCooldown = 0,
			keySequence = KeySequence.new(),

			-- Round misc
			isFacingRight = true,
			soulMate = nil,

			-- General Interface
			isInterfaceOpen = false,

			totalPrettyUIs = 0,
			prettyUIs = { },
			lastPrettyUI = nil,

			-- Help interface
			isHelpOpen = false,
			menuPage = 1,
			menuTabs = { },

			-- Powers interface
			isPowersOpen = false,
			powerInfoIdSelected = nil,
			powerInfoSelectionImageId = nil,

			-- Profile interface
			isProfileOpen = false,

			-- Leaderboard interface
			isLeaderboardOpen = false
		}
	end

	players_insert("lobby", playerName)

	if not isValidPlayer(playerName) then return end

	lowerSyncDelay(playerName)

	-- May bind duplicates
	for _, power in next, powers do
		if power.bindControl then
			power:bindControl(playerName)
		end
	end
	for _, key in next, keyboard do
		bindKeyboard(playerName, key, true, true)
	end

	loadPlayerData(playerName)

	-- Displayed once because the image is never removed
	displayLifeBar(playerName)
end