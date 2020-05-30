local displayProfile
do
	displayProfile = function(playerName, targetPlayer, _cache)
		_cache = _cache or playerCache[playerName]
		local targetCacheData = playerCache[targetPlayer]

		local x, y = 260, 55
		displayPrettyUI("<B><p align='center'><font size='20'><V>" ..
			gsub(targetPlayer, '#', "<font size='13'><G>#", 1), x, y, 280, 330, playerName, false,
			_cache)

		local interfaceId = textAreaId.interface + _cache.totalInterfaceTextareas
		local totalInterfaceImages = _cache.totalInterfaceImages
		local playerInterfaceImages = _cache.interfaceImages

		-- Level bar
		y = y + 35

		totalInterfaceImages = totalInterfaceImages + 1
		playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.levelBar,
			imageTargets.levelBar, x - 1, y, playerName)

		-- Level Title
		interfaceId = interfaceId + 1
		addTextArea(interfaceId, "<p align='center'><font size='14'>" ..
			getText.levelName[targetCacheData.levelIndex]
				[tfm.get.room.playerList[targetPlayer].gender%2 + 1],
			playerName, x, y, 280, 20, 1, 1, 0, true)

		-- Width = currentExp*240 / totalExp
		y = y + 21

		interfaceId = interfaceId + 1
		addTextArea(interfaceId, '', playerName, x + 20, y,
			min(240, targetCacheData.currentLevelXp*240 / targetCacheData.nextLevelXp), 1,
			targetCacheData.levelColor, targetCacheData.levelColor, .75, false)

		-- Level value
		y = y + 18

		interfaceId = interfaceId + 1
		addTextArea(interfaceId, "<p align='center'><font size='16'><B>" .. targetCacheData.level ..
			"\n</b></font>" .. targetCacheData.currentLevelXp .. "/" .. targetCacheData.nextLevelXp
			.. "xp", playerName, x, y, 280, nil, 1, 1, 0, true)
	end
end