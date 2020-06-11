local displayHelp, updateHelp
do
	-- Format translations
	do
		-- Intro
		getText.helpContent[1] = format(getText.helpContent[1], getText.enableParticles,
			prettifyNickname(module.author, 11, nil, nil, "font color='#8FE2D1'"))

		-- Commands
		local commands, parameters = "<V><B>!%s</B> %s<N>- %s", getText.commandsParameters

		local data, index = { }, 0
		for k, v in next, getText.commands do
			index = index + 1
			data[index] = format(commands, k, (parameters[k] or ''), v)
		end
		getText.helpContent[2] = getText.helpContent[2] .. table_concat(data, '\n')
	end

	-- Menu
	local contentFormat = "<font size='14'>"
	local tabStr = "<font size='1'>\n</font><p align='center'>%s<a href='event:helpTab_%s'>%s\n"

	displayHelp = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)
		_cache.isHelpOpen = true

		local helpPage = _cache.helpPage

		local x, y, w = 100, 65, 503

		prettyUI
			.new(x, y, w, 278, playerName, contentFormat .. getText.helpContent[helpPage], _cache)
			:setCloseButton()

		x = x + w + 5
		y = y + 5

		for t = 1, #getText.helpTitles do
			_cache.helpTabs[t] = prettyUI
				.new(x, y + t*30, 120, 30, playerName, format(tabStr,
					(t == helpPage and "<J>" or ''), t,	getText.helpTitles[t]), _cache, true)
		end
	end

	updateHelp = function(playerName, nextHelpPage, _cache)
		_cache = _cache or playerCache[playerName]

		-- Remove highlight color of the last tab
		local currentHelpPage = _cache.helpPage
		updateTextArea(_cache.helpTabs[currentHelpPage].contentTextAreaId, "<N>" .. format(tabStr,
			'', currentHelpPage, getText.helpTitles[currentHelpPage]), playerName)

		-- Highlights new tab
		updateTextArea(_cache.helpTabs[nextHelpPage].contentTextAreaId, format(tabStr, "<J>",
			nextHelpPage, getText.helpTitles[nextHelpPage]), playerName)

		-- Main menu
		updateTextArea(_cache.prettyUIs[1].contentTextAreaId,
			contentFormat .. getText.helpContent[nextHelpPage], playerName)

		_cache.helpPage = nextHelpPage
	end
end