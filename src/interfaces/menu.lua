local displayMenu, updateMenu
do
	local tabStr = "<font size='1'>\n</font><p align='center'>%s<a href='event:menuTab.%s'>%s\n"

	displayMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]
		local menuIndex = _cache.menuIndex

		-- Tabs
		local menuTabId, tmpTabId
		for t = 1, #getText.menuTitles do
			tmpTabId = displayPrettyUI(format(tabStr, (t == menuIndex and "<J>" or ''), t,
				getText.menuTitles[t]), 620, 65 + t*40, 120, 30, playerName, _cache, 1, 3, 2)

			if t == 1 then
				menuTabId = tmpTabId
			end
		end

		_cache.menuTabId = menuTabId - 1

		-- Main menu
		_cache.menuContentId = displayPrettyUI(getText.menuContent[menuIndex], 100, 65, 520, 300,
			playerName, _cache)
	end

	updateMenu = function(playerName, _cache)
		_cache = _cache or playerCache[playerName]

		local menuIndex = _cache.menuIndex
		local lastMenuIndex = _cache.lastMenuIndex

		if lastMenuIndex then
			-- Remove highlight color of the last tab
			updateTextArea(_cache.menuTabId + lastMenuIndex, format(tabStr, '', lastMenuIndex,
				getText.menuTitles[lastMenuIndex]), playerName)
		end

		-- Highlights new tab
		updateTextArea(_cache.menuTabId + menuIndex, format(tabStr, "<J>", menuIndex,
			getText.menuTitles[menuIndex], playerName)

		-- Main menu
		updateTextArea(_cache.menuContentId, getText.menuContent[menuIndex], playerName)
	end
end