local displayLeaderboard
do
	local prettifiedNickname = "<J>#%03d     %s"
	local midFontSize = "<font size='13'>"

	local dataNames = { "xp", "victories", "kills", "rounds" }
	local dataIcons = { "star", "crown", "skull", "ground" }
	local totalData = #dataNames

	displayLeaderboard = function(playerName, _cache, interface)
		local iniX, iniY = 50, 60

		local x = iniX + 5
		local y = iniY + 45

		if not interface then
			if not leaderboard.loaded then
				return chatMessage(getText.leaderboardIsLoading, playerName)
			end

			_cache = _cache or playerCache[playerName]
			textAreaCallbacks["closeInterface"](playerName, _cache)
			_cache.isLeaderboardOpen = true

			local w, h = 700, 330
			interface = prettyUI
				.new(iniX, iniY, w, h, playerName, "<font size='32'>" .. getText.leaderboard,
					_cache)
				:setCloseButton()

			-- Add pagination buttons
			h = iniY + (h - 50)/2
			interface:addClickableImage(interfaceImages.leftArrow, imageTargets.interfaceIcon,
				iniX - 50, h, playerName, 50, 50, "previousPage_leaderboard_displayLeaderboard")
			interface:addClickableImage(interfaceImages.rightArrow, imageTargets.interfaceIcon,
				iniX + w, h, playerName, 50, 50, "nextPage_leaderboard_displayLeaderboard")

			iniX = x
			iniY = y

			-- Background
			interface:addImage(interfaceImages.leaderboardRectangle,
				imageTargets.interfaceRectangle, iniX, iniY + 3, playerName)

			-- Icons
			iniX = iniX + 257
			for i = 1, totalData do
				interface:addImage(interfaceImages[dataIcons[i]], imageTargets.interfaceIcon,
					iniX + i*90, iniY - 30, playerName)
			end
		end

		interface
			:deleteDeletableContent()
			:markDeletableContent(true)

		local listEnd = 17*_cache.leaderboardPage
		local listIni = listEnd - 16

		-- Generates the name list
		local l_community = leaderboard.community
		local l_full_nickname = leaderboard.full_nickname
		local l_pretty_nickname = leaderboard.pretty_nickname

		listEnd = min(listEnd, #l_community)

		interface:addImage(interfaceImages.leaderboardRectangle, imageTargets.interfaceRectangle, x,
			y + 3, playerName)

		local prettifiedNicknames, count = { }, 0
		for i = listIni, listEnd do
			-- Place flags
			count = count + 1
			interface:addImage(l_community[i], imageTargets.interfaceIcon, x + 42,
				y + 5 + (count - 1)*16, playerName)

			-- Prettify nickname
			if l_full_nickname[i] == playerName then
				prettifiedNicknames[count] = format(prettifiedNickname, i, prettifyNickname(
					leaderboard.nickname[i], 11, leaderboard.discriminator[i], "BL", "FC"))
			else
				prettifiedNicknames[count] = format(prettifiedNickname, i, l_pretty_nickname[i])
			end
		end
		prettifiedNicknames = midFontSize .. table_concat(prettifiedNicknames, '\n')

		interface:addTextArea(prettifiedNicknames, playerName, x, y, nil, nil, 1, 1, 0, true)

		-- Inserts other data
		x = x + 230
		for i = 1, totalData do
			interface:addTextArea(midFontSize .. "<font face='courier new'><p align='center'>"
				.. table_concat(leaderboard[dataNames[i]], '\n',
				listIni, listEnd), playerName, x + i*90, y + 1, 80, nil, 1, 1, 0, true)
		end
	end
end