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
		_cache = _cache or playerCache[playerName]

		local x, y = 50, 50

		local interface = prettyUI
			.new(x, y, 700, 330, playerName, titleFormat, _cache)

		x = x + 5
		y = y + 45

		local listIni, listEnd = 1, min(20, #leaderboard.nickname)

		-- Generates the name list
		interface:addImage(interfaceImages.leaderboardRectangle, imageTargets.interfaceRectangle, x,
			y + 3, playerName)

		local l_community = leaderboard.community
		local lFull_nickname = leaderboard.full_nickname
		local lPretty_nickname = leaderboard.pretty_nickname

		local prettifiedNicknames = { }
		for i = listIni, listEnd do
			-- Place flags
			interface:addImage(flags[(flagCodes[l_community[i]] or "xx")],
				imageTargets.interfaceIcon, x + 42, y + 5 + (i - 1)*16, playerName)

			-- Prettify nickname
			if lFull_nickname[i] == playerName then
				prettifiedNicknames[i] = format(prettifiedNickname, i, prettifyNickname(
					leaderboard.nickname[i], 11, leaderboard.discriminator[i], "BL", "FC"))
			else
				prettifiedNicknames[i] = format(prettifiedNickname, i, lPretty_nickname[i])
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