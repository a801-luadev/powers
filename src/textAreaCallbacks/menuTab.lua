do
	textAreaCallbacks["menuTab"] = function(playerName, callback)
		-- menuTab_{tab_id}
		callback = callback[2] * 1

		local cache = playerCache[playerName]
		if cache.menuPage == callback then return end

		updateHelp(playerName, callback, cache)
	end
end