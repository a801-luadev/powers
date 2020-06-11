local displayProfile
do
	local font = "<font size='%d'>"
	local centerAndFont = "<p align='center'>" .. font
	local nicknameFormat = centerAndFont .. "<font face='consolas,courier new,soopafresh'>%s"
	local levelNameFormat = centerAndFont .. "%s"
	local xpFormat = centerAndFont .. "<B>%d</B>\n</font>%d/%dxp"
	local valueFormat = font .. "%s"
	local dataNameFormat = "<font face='courier new'>%s"

	local dataNames = { "victories", "kills", "rounds" }
	local dataIcons = { "crown", "skull", "ground" }
	local totalData = #dataNames

	local displayLevelBar = function(playerName, targetPlayer, targetCacheData, x, y, interface)
		y = y + 35

		interface:addImage(interfaceImages.levelBar, imageTargets.levelBar, x, y, playerName)

		-- Level Title
		interface:addTextArea(format(levelNameFormat, 14,
			getText.levelName[targetCacheData.levelIndex]
				[tfm.get.room.playerList[targetPlayer].gender%2 + 1]), playerName, x, y, 280, 20, 1,
			1, 0, true)

		-- Width = currentExp*240 / totalExp
		y = y + 21

		interface:addTextArea('', playerName, x + 20, y, 240, 1, 0x152D30, 0x152D30, 1, false)

		interface:addTextArea('', playerName, x + 20, y,
			min(240, targetCacheData.currentLevelXp*240 / targetCacheData.nextLevelXp), 1,
			targetCacheData.levelColor, targetCacheData.levelColor, .75, false)

		-- Level value
		y = y + 18

		interface:addTextArea(format(xpFormat, 16, targetCacheData.level,
			targetCacheData.currentLevelXp, targetCacheData.nextLevelXp), playerName, x, y, 280,
			nil, 1, 1, 0, true)

		return x + 13, y + 65
	end

	displayProfile = function(playerName, targetPlayer, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)
		_cache.isProfileOpen = true
		local targetCacheData = playerCache[targetPlayer]

		local x, y = 260, 55
		local interface = prettyUI
			.new(x, y, 280, 330, playerName, format(nicknameFormat, 20,
				prettifyNickname(targetPlayer, 13)), _cache)
			:setCloseButton()

		-- Level bar
		x, y = displayLevelBar(playerName, targetPlayer, targetCacheData, x, y, interface)

		-- Data
		local sumX
		for i = 1, totalData do
			sumX = x + ((i + 1) % 2)*135

			interface:addTextArea(format(dataNameFormat, getText.profileData[dataNames[i]]),
				playerName, sumX - 8, y - 12, nil, nil, 1, 1, 0, true)

			interface:addImage(interfaceImages.smallRectangle, imageTargets.interfaceRectangle,
				sumX - 2, y - 2, playerName)

			interface:addImage(interfaceImages[dataIcons[i]], imageTargets.interfaceIcon, sumX,
				y + 5, playerName)

			interface:addTextArea(format(valueFormat, 14, playerData:get(targetPlayer,
				dataNames[i])), playerName, sumX + 30, y + 8, nil, nil, 1, 1, 0, true)

			if i % 2 == 0 then
				y = y + 44
			end
		end
	end
end