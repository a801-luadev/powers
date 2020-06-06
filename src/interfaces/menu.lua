local displayMenu, updateMenu
do
	-- Format translations
	do
		-- Intro
		getText.menuContent[1] = format(getText.menuContent[1], getText.enableParticles)

		-- Commands
		local commands, parameters = "<V><B>!%s</B> %s<N>- %s", getText.commandsParameters

		local data, index = { }, 0
		for k, v in next, getText.commands do
			index = index + 1
			data[index] = format(commands, k, (parameters[k] or ''), v)
		end
		getText.menuContent[2] = getText.menuContent[2] .. table_concat(data, '\n')
	end

	-- Menu
	local contentFormat = "<font size='14'>"
	local tabStr = "<font size='1'>\n</font><p align='center'>%s<a href='event:menuTab_%s'>%s\n"

	displayMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		callbacks["closeInterface"](playerName, nil, nil, _cache)

		local menuPage = _cache.menuPage

		local x, y, w = 100, 65, 503

		prettyUI
			.new(x, y, w, 278, playerName, contentFormat .. getText.menuContent[menuPage], _cache)
			:setCloseButton()

		x = x + w + 5
		y = y + 5

		for t = 1, #getText.menuTitles do
			_cache.menuTabs[t] = prettyUI
				.new(x, y + t*30, 120, 30, playerName, format(tabStr,
					(t == menuPage and "<J>" or ''), t,	getText.menuTitles[t]), _cache, true)
		end
	end

	updateMenu = function(playerName, nextMenuPage, _cache)
		_cache = _cache or playerCache[playerName]

		-- Remove highlight color of the last tab
		local currentMenuPage = _cache.menuPage
		updateTextArea(_cache.menuTabs[currentMenuPage].contentTextAreaId, "<N>" .. format(tabStr,
			'', currentMenuPage, getText.menuTitles[currentMenuPage]), playerName)

		-- Highlights new tab
		updateTextArea(_cache.menuTabs[nextMenuPage].contentTextAreaId, format(tabStr, "<J>",
			nextMenuPage, getText.menuTitles[nextMenuPage]), playerName)

		-- Main menu
		updateTextArea(_cache.prettyUIs[1].contentTextAreaId,
			contentFormat .. getText.menuContent[nextMenuPage], playerName)

		_cache.menuPage = nextMenuPage
	end
end