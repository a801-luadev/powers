local displayProfile
do
	local font = "<font size='%d'>"
	local centerAndFont = "<p align='center'>" .. font
	local nicknameFormat = centerAndFont .. "<B><V>%s"
	local discriminatorFormat = "<font size='13'><G>#"
	local levelNameFormat = centerAndFont .. "%s"
	local xpFormat = centerAndFont .. "<B>%d</B>\n</font>%d/%dxp"
	local valueFormat = font .. "%s"
	local dataNameFormat = "<font face='courier new'>%s"

	local dataNames = { "victories", "kills", "rounds" }
	local dataIcons = { "crown", "skull", "ground" }
	local totalData = #dataNames

	local displayLevelBar = function(playerName, targetPlayer, targetCacheData, x, y, interfaceId,
		playerInterfaceImages, totalInterfaceImages)
		y = y + 35

		totalInterfaceImages = totalInterfaceImages + 1
		playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.levelBar,
			imageTargets.levelBar, x - 1, y, playerName)

		-- Level Title
		interfaceId = interfaceId + 1
		addTextArea(interfaceId, format(levelNameFormat, 14,
			getText.levelName[targetCacheData.levelIndex]
				[tfm.get.room.playerList[targetPlayer].gender%2 + 1]), playerName, x, y, 280, 20, 1,
			1, 0, true)

		-- Width = currentExp*240 / totalExp
		y = y + 21

		interfaceId = interfaceId + 1
		addTextArea(interfaceId, '', playerName, x + 20, y,
			min(240, targetCacheData.currentLevelXp*240 / targetCacheData.nextLevelXp), 1,
			targetCacheData.levelColor, targetCacheData.levelColor, .75, false)

		-- Level value
		y = y + 18

		interfaceId = interfaceId + 1
		addTextArea(interfaceId, format(xpFormat, 16, targetCacheData.level,
			targetCacheData.currentLevelXp, targetCacheData.nextLevelXp), playerName, x, y, 280,
			nil, 1, 1, 0, true)

		return x + 10, y + 65, interfaceId, totalInterfaceImages
	end

	displayProfile = function(playerName, targetPlayer, _cache)
		_cache = _cache or playerCache[playerName]
		local targetCacheData = playerCache[targetPlayer]

		local x, y = 260, 55
		displayPrettyUI(format(nicknameFormat, 20, gsub(targetPlayer, '#', discriminatorFormat, 1)),
			x, y, 280, 330, playerName, false, _cache)

		local interfaceId = textAreaId.interface + _cache.totalInterfaceTextareas
		local totalInterfaceImages = _cache.totalInterfaceImages
		local playerInterfaceImages = _cache.interfaceImages

		-- Level bar
		x, y, interfaceId, totalInterfaceImages = displayLevelBar(playerName, targetPlayer,
			targetCacheData, x, y, interfaceId, playerInterfaceImages, totalInterfaceImages)

		-- Data
		local sumX
		for i = 1, totalData do
			sumX = x + ((i + 1) % 2)*135

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, format(dataNameFormat, getText.profileData[dataNames[i]]),
				playerName, sumX - 8, y - 12, nil, nil, 1, 1, 0, true)

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages.smallRectangle,
				imageTargets.interfaceRectangle, sumX - 2, y - 2, playerName)

			totalInterfaceImages = totalInterfaceImages + 1
			playerInterfaceImages[totalInterfaceImages] = addImage(interfaceImages[dataIcons[i]],
				imageTargets.interfaceIcon, sumX, y + 5, playerName)

			interfaceId = interfaceId + 1
			addTextArea(interfaceId, format(valueFormat, 14,
				playerData:get(targetPlayer, dataNames[i])), playerName, sumX + 30, y + 8,
				nil, nil, 1, 1, 0, true)

			if i % 2 == 0 then
				y = y + 44
			end
		end
	end
end