local displayHelp, updateHelp
do
	-- Format translations
	local helpContent = getText.helpContent
	do
		-- Intro
		helpContent[1] = format(getText.helpContent[1], getText.enableParticles,
			prettifyNickname(module.author, 11, nil, nil, "font color='#8FE2D1'"))
	end

	-- Menu
	local contentFormat = "<font size='13'>"
	local tabStr = "<font size='1'>\n</font><p align='center'>%s<a href='event:helpTab_%s'>%s\n"

	local getPageContent = function(page, _cache)
		if page == 2 then
			return helpContent[2] .. (_cache.commands or '?')
		else
			return helpContent[page]
		end
	end

	displayHelp = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		textAreaCallbacks["closeInterface"](playerName, _cache)
		_cache.isHelpOpen = true

		local helpPage = _cache.helpPage

		local x, y, w = 100, 65, 503

		prettyUI
			.new(x, y, w, 308, playerName, contentFormat .. getPageContent(helpPage, _cache),
				_cache)
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
			contentFormat .. getPageContent(nextHelpPage, _cache), playerName)

		_cache.helpPage = nextHelpPage
	end
end