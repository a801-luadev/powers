do
	callbacks["menuTab"] = function(playerName, callback)
		callback = callback[2] * 1

		local cache = playerCache[playerName]
		if cache.menuIndex == callback then return end

		cache.lastMenuIndex = cache.menuIndex
		cache.menuIndex = callback[2] * 1

		updateMenu(playerName, cache)
	end
end