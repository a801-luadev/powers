eventNewPlayer = function(playerName)
	playerCache[playerName] = {
		-- Level and XP
		level = 1,
		currentLevelXp = nil,
		nextLevelXp = nil,
		roundLevel = nil, -- Level on round start
		levelIndex = nil, -- ex: 10, 20, 30
		levelColor = nil,
		extraXp = 0,

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

		lastDamageBy = nil,
		lastDamageTime = nil,

		spawnHearts = false,

		-- General Interface
		isInterfaceOpen = false,

		totalPrettyUIs = 0,
		prettyUIs = { },
		lastPrettyUI = nil,

		interfaceActionCooldown = 0,

		-- Help interface
		isHelpOpen = false,
		helpPage = 1,
		helpTabs = { },
		commands = nil,

		-- Powers interface
		isPowersOpen = false,
		powerInfoIdSelected = nil,
		powerInfoSelectionImageId = nil,

		-- Profile interface
		isProfileOpen = false,
		badges = nil,

		-- Leaderboard interface
		isLeaderboardOpen = false,
		leaderboardPage = 1,

		-- Misc
		chatNickname = prettifyNickname(playerName, nil, nil, "/B><G", 'B')
	}

	players_insert("lobby", playerName)

	chatMessage(getText.greeting, playerName)

	local isValid, isBanned, playerId = isValidPlayer(playerName)
	if not isValid then
		if isBanned then
			warnBanMessage(playerName, isBanned)
		end
		return
	end

	if totalCurrentMaps > 0 then -- File already loaded
		playerCache[playerName].commands = generateCommandHelp(playerId, playerName)
		keyboardCallbacks[keyboard.H](playerName, playerCache[playerName])
	end

	if isReviewMode then
		if isFreeMode then
			chatMessage(getText.freeMode, playerName)
		else
			chatMessage(getText.enableReviewMode, playerName)
		end
	end

	tfm.exec.lowerSyncDelay(playerName)

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