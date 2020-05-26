local displayMenu, updateMenu
do
	local tabStr = "<font size='1'>\n</font><p align='center'>%s<a href='event:menuTab_%s'>%s\n"

	displayMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local menuPage = _cache.menuPage

		-- Tabs
		local menuTabId, tmpTabId
		for t = 1, #getText.menuTitles do
			tmpTabId = displayPrettyUI(format(tabStr, (t == menuPage and "<J>" or ''), t,
				getText.menuTitles[t]), 615, 60 + t*35, 120, 30, playerName, _cache, 1, 3, 2)

			if t == 1 then
				menuTabId = tmpTabId
			end
		end

		_cache.menuTabId = menuTabId - 1

		-- Main menu
		_cache.menuContentId = displayPrettyUI(getText.menuContent[menuPage], 100, 65, 520, 300,
			playerName, _cache)
	end

	updateMenu = function(playerName, menuPage, _cache)
		_cache = _cache or playerCache[playerName]

		local currentMenuPage = _cache.menuPage

		if currentMenuPage then
			-- Remove highlight color of the last tab
			updateTextArea(_cache.menuTabId + currentMenuPage, "<N>" .. format(tabStr, '',
				currentMenuPage, getText.menuTitles[currentMenuPage]), playerName)
		end

		-- Highlights new tab
		updateTextArea(_cache.menuTabId + menuPage, format(tabStr, "<J>", menuPage,
			getText.menuTitles[menuPage]), playerName)

		-- Main menu
		updateTextArea(_cache.menuContentId, getText.menuContent[menuPage], playerName)

		_cache.menuPage = menuPage
	end
end