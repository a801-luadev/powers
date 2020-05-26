do
	callbacks["menuTab"] = function(playerName, callback)
		-- menuTab_{tab_id}
		callback = callback[2] * 1

		local cache = playerCache[playerName]
		if cache.menuIndex == callback then return end

		cache.lastMenuIndex = cache.menuIndex
		cache.menuIndex = callback

		updateMenu(playerName, cache)
	end
end