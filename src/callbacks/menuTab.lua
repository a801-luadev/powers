do
	callbacks["menuTab"] = function(playerName, callback)
		local cache = playerCache[playerName]

		cache.lastMenuIndex = cache.menuIndex
		cache.menuIndex = callback[2] * 1

		updateMenu(playerName, cache)
	end
end