local displayLeaderboard
do
	local prettifiedNickname = "<J>#%03d     %s"
	local midFontSize = "<font size='13'>"
	local titleFormat = "<font size='32'>" .. getText.leaderboard
	local dataFormat = midFontSize .. "<font face='courier new'><p align='center'>"

	local dataNames = { "xp", "victories", "kills", "rounds" }
	local dataIcons = { "star", "crown", "skull", "ground" }
	local totalData = #dataNames

	displayLeaderboard = function(playerName, _cache)
		if not leaderboard.loaded then
			return chatMessage(getText.leaderboardIsLoading, playerName)
		end

		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, nil, nil, _cache)
		_cache.isLeaderboardOpen = true

		local x, y = 50, 50

		local interface = prettyUI
			.new(x, y, 700, 330, playerName, titleFormat, _cache)
			:setCloseButton()

		x = x + 5
		y = y + 45

		local listIni = 1
		local listEnd = min(17, #leaderboard.nickname)

		-- Generates the name list
		interface:addImage(interfaceImages.leaderboardRectangle, imageTargets.interfaceRectangle, x,
			y + 3, playerName)

		local l_community = leaderboard.community
		local l_full_nickname = leaderboard.full_nickname
		local l_pretty_nickname = leaderboard.pretty_nickname

		local prettifiedNicknames = { }
		for i = listIni, listEnd do
			-- Place flags
			interface:addImage(flags[(flagCodes[l_community[i]] or "xx")],
				imageTargets.interfaceIcon, x + 42, y + 5 + (i - 1)*16, playerName)

			-- Prettify nickname
			if l_full_nickname[i] == playerName then
				prettifiedNicknames[i] = format(prettifiedNickname, i, prettifyNickname(
					leaderboard.nickname[i], 11, leaderboard.discriminator[i], "BL", "FC"))
			else
				prettifiedNicknames[i] = format(prettifiedNickname, i, l_pretty_nickname[i])
			end
		end
		prettifiedNicknames = midFontSize .. table_concat(prettifiedNicknames, '\n')

		interface:addTextArea(prettifiedNicknames, playerName, x, y, nil, nil, 1, 1, 0, true)

		x = x + 230

		-- Inserts other data
		local sumX
		for i = 1, totalData do
			sumX = x + i*90

			interface:addImage(interfaceImages[dataIcons[i]], imageTargets.interfaceIcon, sumX + 27,
				y - 30, playerName)

			interface:addTextArea(dataFormat .. table_concat(leaderboard[dataNames[i]], '\n',
				listIni, listEnd), playerName, sumX, y + 1, 80, nil, 1, 1, 0, true)
		end
	end
end